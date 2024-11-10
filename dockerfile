# Use the .NET Core 2.0 SDK for compatibility
FROM mcr.microsoft.com/dotnet/sdk:2.1 AS build

WORKDIR /app
COPY hello-world-api/hello-world-api.csproj .
RUN dotnet restore

COPY hello-world-api/hello-world-api.csproj .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:2.1
WORKDIR /app
COPY --from=build /app/out .

EXPOSE 80
ENTRYPOINT ["dotnet", "dotnet-hello-world.dll"]
