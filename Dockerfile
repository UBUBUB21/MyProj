# ===== ЭТАП 1: СБОРКА =====
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Копируем файл проекта
COPY MyWebApp.csproj .
RUN dotnet restore

# Копируем весь код
COPY . .

# Собираем приложение
RUN dotnet publish -c Release -o /app/publish

# ===== ЭТАП 2: ЗАПУСК =====
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Копируем собранный проект из этапа сборки
COPY --from=build /app/publish .

# Открываем порт для приложения
EXPOSE 8080

# Запускаем приложение
ENTRYPOINT ["dotnet", "MyWebApp.dll"]