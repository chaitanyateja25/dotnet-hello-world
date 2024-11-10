# Use the official .NET image as a base
FROM FROM mcr.microsoft.com/dotnet/sdk:2.1 AS build
WORKDIR /app
EXPOSE 80

# Copy and restore the .NET application
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY hello-world-api .
RUN dotnet restore "hello-world-api.csproj"

# Build and publish the app
COPY . .
RUN dotnet publish "hello-world-api.csproj" -c Release -o /app/publish

# Build runtime image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "dotnet-hello-world.dll"]
