module 0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather {
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
        positive_latitude: bool,
        longitude: u32,
        positive_longitude: bool,
        weather_id: u16,
        temp: u32,
        pressure: u32,
        humidity: u8,
        visibility: u16,
        wind_speed: u16,
        wind_deg: u16,
        wind_gust: 0x1::option::Option<u16>,
        clouds: u8,
        dt: u32,
    }

    struct WeatherNFT has store, key {
        id: 0x2::object::UID,
        geoname_id: u32,
        name: 0x1::string::String,
        country: 0x1::string::String,
        latitude: u32,
        positive_latitude: bool,
        longitude: u32,
        positive_longitude: bool,
        weather_id: u16,
        temp: u32,
        pressure: u32,
        humidity: u8,
        visibility: u16,
        wind_speed: u16,
        wind_deg: u16,
        wind_gust: 0x1::option::Option<u16>,
        clouds: u8,
        dt: u32,
    }

    public fun add_city(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: u32, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u32, arg6: bool, arg7: u32, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = CityWeatherOracle{
            id                 : 0x2::object::new(arg9),
            geoname_id         : arg2,
            name               : arg3,
            country            : arg4,
            latitude           : arg5,
            positive_latitude  : arg6,
            longitude          : arg7,
            positive_longitude : arg8,
            weather_id         : 0,
            temp               : 0,
            pressure           : 0,
            humidity           : 0,
            visibility         : 0,
            wind_speed         : 0,
            wind_deg           : 0,
            wind_gust          : 0x1::option::none<u16>(),
            clouds             : 0,
            dt                 : 0,
        };
        0x2::dynamic_object_field::add<u32, CityWeatherOracle>(&mut arg1.id, arg2, v0);
    }

    public fun clouds(arg0: &CityWeatherOracle) : u8 {
        arg0.clouds
    }

    public fun country(arg0: &CityWeatherOracle) : 0x1::string::String {
        arg0.country
    }

    public fun dt(arg0: &CityWeatherOracle) : u32 {
        arg0.dt
    }

    public fun geoname_id(arg0: &CityWeatherOracle) : u32 {
        arg0.geoname_id
    }

    public fun humidity(arg0: &CityWeatherOracle) : u8 {
        arg0.humidity
    }

    fun init(arg0: WEATHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WEATHER>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = WeatherOracle{
            id          : 0x2::object::new(arg1),
            address     : 0x2::tx_context::sender(arg1),
            name        : 0x1::string::utf8(b"SuiMeteo"),
            description : 0x1::string::utf8(b"A weather oracle for posting weather updates (temperature, pressure, humidity, visibility, wind metrics and cloud state) for major cities around the world. Currently the data is fetched from https://openweathermap.org. SuiMeteo provides the best available information, but it does not guarantee its accuracy, completeness, reliability, suitability, or availability. Use it at your own risk and discretion."),
        };
        0x2::transfer::share_object<WeatherOracle>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
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
            id                 : 0x2::object::new(arg2),
            geoname_id         : v0.geoname_id,
            name               : v0.name,
            country            : v0.country,
            latitude           : v0.latitude,
            positive_latitude  : v0.positive_latitude,
            longitude          : v0.longitude,
            positive_longitude : v0.positive_longitude,
            weather_id         : v0.weather_id,
            temp               : v0.temp,
            pressure           : v0.pressure,
            humidity           : v0.humidity,
            visibility         : v0.visibility,
            wind_speed         : v0.wind_speed,
            wind_deg           : v0.wind_deg,
            wind_gust          : v0.wind_gust,
            clouds             : v0.clouds,
            dt                 : v0.dt,
        }
    }

    public fun name(arg0: &CityWeatherOracle) : 0x1::string::String {
        arg0.name
    }

    public fun positive_latitude(arg0: &CityWeatherOracle) : bool {
        arg0.positive_latitude
    }

    public fun positive_longitude(arg0: &CityWeatherOracle) : bool {
        arg0.positive_longitude
    }

    public fun pressure(arg0: &CityWeatherOracle) : u32 {
        arg0.pressure
    }

    public fun remove_city(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: u32) {
        let CityWeatherOracle {
            id                 : v0,
            geoname_id         : _,
            name               : _,
            country            : _,
            latitude           : _,
            positive_latitude  : _,
            longitude          : _,
            positive_longitude : _,
            weather_id         : _,
            temp               : _,
            pressure           : _,
            humidity           : _,
            visibility         : _,
            wind_speed         : _,
            wind_deg           : _,
            wind_gust          : _,
            clouds             : _,
            dt                 : _,
        } = 0x2::dynamic_object_field::remove<u32, CityWeatherOracle>(&mut arg1.id, arg2);
        0x2::object::delete(v0);
    }

    public fun temp(arg0: &CityWeatherOracle) : u32 {
        arg0.temp
    }

    public fun update(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: u32, arg3: u16, arg4: u32, arg5: u32, arg6: u8, arg7: u16, arg8: u16, arg9: u16, arg10: 0x1::option::Option<u16>, arg11: u8, arg12: u32) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u32, CityWeatherOracle>(&mut arg1.id, arg2);
        v0.weather_id = arg3;
        v0.temp = arg4;
        v0.pressure = arg5;
        v0.humidity = arg6;
        v0.visibility = arg7;
        v0.wind_speed = arg8;
        v0.wind_deg = arg9;
        v0.wind_gust = arg10;
        v0.clouds = arg11;
        v0.dt = arg12;
    }

    public fun update_description(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: 0x1::string::String) {
        arg1.description = arg2;
    }

    public fun update_name(arg0: &AdminCap, arg1: &mut WeatherOracle, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public fun visibility(arg0: &CityWeatherOracle) : u16 {
        arg0.visibility
    }

    public fun weather_id(arg0: &CityWeatherOracle) : u16 {
        arg0.weather_id
    }

    public fun wind_deg(arg0: &CityWeatherOracle) : u16 {
        arg0.wind_deg
    }

    public fun wind_gust(arg0: &CityWeatherOracle) : 0x1::option::Option<u16> {
        arg0.wind_gust
    }

    public fun wind_speed(arg0: &CityWeatherOracle) : u16 {
        arg0.wind_speed
    }

    // decompiled from Move bytecode v6
}

