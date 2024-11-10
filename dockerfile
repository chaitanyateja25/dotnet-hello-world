# Use the .NET Core 2.1 SDK for compatibility
FROM mcr.microsoft.com/dotnet/sdk:2.1 AS build

WORKDIR /app

# Copy the project file and restore dependencies
COPY hello-world-api/hello-world-api.csproj ./hello-world-api/
WORKDIR /app/hello-world-api
RUN dotnet restore

# Copy all the source files
COPY hello-world-api/ .

# Publish the application
RUN dotnet publish -c Release -o out

# Use the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:2.1
WORKDIR /app
COPY --from=build /app/hello-world-api/out .

EXPOSE 80
ENTRYPOINT ["dotnet", "hello-world-api.dll"]
