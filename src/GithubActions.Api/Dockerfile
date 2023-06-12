FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/GithubActions.Api/GithubActions.Api.csproj", "src/GithubActions.Api/"]
RUN dotnet restore "src/GithubActions.Api/GithubActions.Api.csproj"
COPY . .
WORKDIR "/src/src/GithubActions.Api"
RUN dotnet build "GithubActions.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "GithubActions.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "GithubActions.Api.dll"]
