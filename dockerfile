FROM mcr.microsoft.com/dotnet/sdk:8.0 as build-env
WORKDIR /App
COPY . ./

RUN dotnet restore
RUN dotnet publish -c Release -o out -r linux-x64

FROM mcr.microsoft.com/dotnet/aspnet:8.0
COPY --from=build-env /App/out .

RUN apt update
RUN apt upgrade
RUN apt install -y curl

EXPOSE 80
ENTRYPOINT ["dotnet","BookingReview.dll"]