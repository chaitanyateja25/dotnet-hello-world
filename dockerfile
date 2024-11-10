FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build-env
WORKDIR /app

COPY hello-world-api .
RUN dotnet restore
RUN dotnet build -c Release -o /app/build

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS runtime
WORKDIR /app

COPY --from=build-env /app/build .
EXPOSE 80
ENTRYPOINT ["dotnet", "dotnet-hello-world.dll"]
