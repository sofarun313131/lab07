# Регистрируем версию GTest
hunter_config(GTest VERSION 1.7.0-hunter-9)

# Передаем компилятору флаг "не ругаться на неинициализированные переменные" внутрь Hunter
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-error=maybe-uninitialized")
