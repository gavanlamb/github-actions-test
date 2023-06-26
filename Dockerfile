FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS base
ARG BUILD_NUMBER=0.0.0.1
WORKDIR /build
COPY "GithubActions.sln" "GithubActions.sln"
COPY "src/GithubActions.Api/GithubActions.Api.csproj" "src/GithubActions.Api/"
COPY "tests/GithubActions.Api.UnitTests/GithubActions.Api.UnitTests.csproj" "tests/GithubActions.Api.UnitTests/"
RUN dotnet restore GithubActions.sln
COPY . .
RUN dotnet build -c Release /p:Version=$BUILD_NUMBER /p:AssemblyVersion=$BUILD_NUMBER /p:FileVersion=$BUILD_NUMBER /p:ContinuousIntegrationBuild=true


FROM base AS unit-tests
WORKDIR /build
ENTRYPOINT dotnet test --collect:"XPlat Code Coverage" --no-build --configuration Release --results-directory /artifacts/test/results/ tests/GithubActions.Api.UnitTests/GithubActions.Api.UnitTests.csproj --settings tests/default.runsettings
#&& \


FROM base AS publish-api
RUN dotnet publish "src/GithubActions.Api/GithubActions.Api.csproj" -c Release -o /app/publish --no-build

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS api
WORKDIR /app
COPY --from=publish-api /app/publish .
ENTRYPOINT ["dotnet", "GithubActions.Api.dll"]