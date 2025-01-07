module 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WEATHER has drop {
        dummy_field: bool,
    }

    struct WeatherOracle has key {
        id: 0x2::object::UID,
        address: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct CityWeatherOracle has store, key {
        id: 0x2::object::UID,
        geoname_id: u32,
        name: 0x1::string::String,
        country: 0x1::string::String,
        latitude: u32,
        longitude: u32,
        temp: u32,
        visibility: u16,
        wind_speed: u16,
        wind_deg: 0x1::string::String,
        clouds: u8,
        is_rain: bool,
        rain_fall: 0x1::string::String,
    }

    struct WeatherNFT has store, key {
        id: 0x2::object::UID,
        geoname_id: u32,
        name: 0x1::string::String,
        country: 0x1::string::String,
        latitude: u32,
        longitude: u32,
        temp: u32,
        visibility: u16,
        wind_speed: u16,
        wind_deg: 0x1::string::String,
        clouds: u8,
        is_rain: bool,
        rain_fall: 0x1::string::String,
    }

    public fun add_city(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: u32, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CityWeatherOracle{
            id         : 0x2::object::new(arg7),
            geoname_id : arg2,
            name       : arg3,
            country    : arg4,
            latitude   : arg5,
            longitude  : arg6,
            temp       : 0,
            visibility : 0,
            wind_speed : 0,
            wind_deg   : 0x1::string::utf8(b"East"),
            clouds     : 0,
            is_rain    : false,
            rain_fall  : 0x1::string::utf8(b"None"),
        };
        0x2::dynamic_object_field::add<u32, CityWeatherOracle>(&mut arg1.id, arg2, v0);
    }

    public fun city_weather_oracle_clouds(arg0: &WeatherOracle, arg1: u32) : u8 {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).clouds
    }

    public fun city_weather_oracle_country(arg0: &WeatherOracle, arg1: u32) : 0x1::string::String {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).country
    }

    public fun city_weather_oracle_geoname_id(arg0: &WeatherOracle, arg1: u32) : u32 {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).geoname_id
    }

    public fun city_weather_oracle_is_rain(arg0: &WeatherOracle, arg1: u32) : bool {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).is_rain
    }

    public fun city_weather_oracle_latitude(arg0: &WeatherOracle, arg1: u32) : u32 {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).latitude
    }

    public fun city_weather_oracle_longitude(arg0: &WeatherOracle, arg1: u32) : u32 {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).longitude
    }

    public fun city_weather_oracle_name(arg0: &WeatherOracle, arg1: u32) : 0x1::string::String {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).name
    }

    public fun city_weather_oracle_rain_fall(arg0: &WeatherOracle, arg1: u32) : 0x1::string::String {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).rain_fall
    }

    public fun city_weather_oracle_temp(arg0: &WeatherOracle, arg1: u32) : u32 {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).temp
    }

    public fun city_weather_oracle_visibility(arg0: &WeatherOracle, arg1: u32) : u16 {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).visibility
    }

    public fun city_weather_oracle_wind_deg(arg0: &WeatherOracle, arg1: u32) : 0x1::string::String {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).wind_deg
    }

    public fun city_weather_oracle_wind_speed(arg0: &WeatherOracle, arg1: u32) : u16 {
        0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1).wind_speed
    }

    public fun clouds(arg0: &CityWeatherOracle) : u8 {
        arg0.clouds
    }

    public fun country(arg0: &CityWeatherOracle) : 0x1::string::String {
        arg0.country
    }

    public fun geoname_id(arg0: &CityWeatherOracle) : u32 {
        arg0.geoname_id
    }

    fun init(arg0: WEATHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WEATHER>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = WeatherOracle{
            id          : 0x2::object::new(arg1),
            address     : 0x2::tx_context::sender(arg1),
            name        : 0x1::string::utf8(b"Weminal"),
            description : 0x1::string::utf8(b"A weather oracle for posting weather updates (temperature, pressure, humidity, visibility, wind metrics and cloud state) for major cities around the world. Currently the data is fetched from https://openweathermap.org. SuiMeteo provides the best available information, but it does not guarantee its accuracy, completeness, reliability, suitability, or availability. Use it at your own risk and discretion."),
        };
        0x2::transfer::share_object<WeatherOracle>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, @0x8d9f68271c525e6a35d75bc7afb552db1bf2f44bb65e860b356e08187cb9fa3d);
    }

    public fun is_rain(arg0: &CityWeatherOracle) : bool {
        arg0.is_rain
    }

    public fun latitude(arg0: &CityWeatherOracle) : u32 {
        arg0.latitude
    }

    public fun longitude(arg0: &CityWeatherOracle) : u32 {
        arg0.longitude
    }

    public fun mint(arg0: &WeatherOracle, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : WeatherNFT {
        let v0 = 0x2::dynamic_object_field::borrow<u32, CityWeatherOracle>(&arg0.id, arg1);
        WeatherNFT{
            id         : 0x2::object::new(arg2),
            geoname_id : v0.geoname_id,
            name       : v0.name,
            country    : v0.country,
            latitude   : v0.latitude,
            longitude  : v0.longitude,
            temp       : v0.temp,
            visibility : v0.visibility,
            wind_speed : v0.wind_speed,
            wind_deg   : v0.wind_deg,
            clouds     : v0.clouds,
            is_rain    : v0.is_rain,
            rain_fall  : v0.rain_fall,
        }
    }

    public fun name(arg0: &CityWeatherOracle) : 0x1::string::String {
        arg0.name
    }

    public fun rain_fall(arg0: &CityWeatherOracle) : 0x1::string::String {
        arg0.rain_fall
    }

    public fun remove_city(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: u32) {
        let CityWeatherOracle {
            id         : v0,
            geoname_id : _,
            name       : _,
            country    : _,
            latitude   : _,
            longitude  : _,
            temp       : _,
            visibility : _,
            wind_speed : _,
            wind_deg   : _,
            clouds     : _,
            is_rain    : _,
            rain_fall  : _,
        } = 0x2::dynamic_object_field::remove<u32, CityWeatherOracle>(&mut arg1.id, arg2);
        0x2::object::delete(v0);
    }

    public fun temp(arg0: &CityWeatherOracle) : u32 {
        arg0.temp
    }

    public fun update(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: u32, arg3: u32, arg4: u16, arg5: u16, arg6: 0x1::string::String, arg7: u8, arg8: bool, arg9: 0x1::string::String) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u32, CityWeatherOracle>(&mut arg1.id, arg2);
        v0.temp = arg3;
        v0.visibility = arg4;
        v0.wind_speed = arg5;
        v0.wind_deg = arg6;
        v0.clouds = arg7;
        v0.is_rain = arg8;
        v0.rain_fall = arg9;
    }

    public fun update_name(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public fun visibility(arg0: &CityWeatherOracle) : u16 {
        arg0.visibility
    }

    public fun wind_deg(arg0: &CityWeatherOracle) : 0x1::string::String {
        arg0.wind_deg
    }

    public fun wind_speed(arg0: &CityWeatherOracle) : u16 {
        arg0.wind_speed
    }

    // decompiled from Move bytecode v6
}

