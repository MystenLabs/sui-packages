module 0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::weather {
    struct WEATHER has drop {
        dummy_field: bool,
    }

    struct One {
        dummy_field: bool,
    }

    struct Hour {
        dummy_field: bool,
    }

    struct Day {
        dummy_field: bool,
    }

    struct Week {
        dummy_field: bool,
    }

    struct WeatherOracle has key {
        id: 0x2::object::UID,
    }

    struct CityWeatherOracle has store, key {
        id: 0x2::object::UID,
        weather: 0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle::Oracle<Weather<One>>,
    }

    struct Weather<phantom T0> has copy, drop, store {
        geoname_id: u32,
        latitude: u32,
        positive_latitude: bool,
        longitude: u32,
        positive_longitude: bool,
        weather_id: u8,
        temp: u64,
        pressure: u64,
        humidity: u64,
        visibility: u64,
        wind_speed: u64,
        wind_deg: u64,
        wind_gust: u64,
        clouds: u64,
        dt: u64,
    }

    public fun empty<T0>() : Weather<T0> {
        Weather<T0>{
            geoname_id         : 0,
            latitude           : 0,
            positive_latitude  : false,
            longitude          : 0,
            positive_longitude : false,
            weather_id         : 0,
            temp               : 0,
            pressure           : 0,
            humidity           : 0,
            visibility         : 0,
            wind_speed         : 0,
            wind_deg           : 0,
            wind_gust          : 0,
            clouds             : 0,
            dt                 : 0,
        }
    }

    public fun new<T0>(arg0: u32, arg1: u32, arg2: bool, arg3: u32, arg4: bool, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64) : Weather<T0> {
        Weather<T0>{
            geoname_id         : arg0,
            latitude           : arg1,
            positive_latitude  : arg2,
            longitude          : arg3,
            positive_longitude : arg4,
            weather_id         : arg5,
            temp               : arg6,
            pressure           : arg7,
            humidity           : arg8,
            visibility         : arg9,
            wind_speed         : arg10,
            wind_deg           : arg11,
            wind_gust          : arg12,
            clouds             : arg13,
            dt                 : arg14,
        }
    }

    public fun update(arg0: &0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle::WriterCap, arg1: &mut WeatherOracle, arg2: u32, arg3: u32, arg4: bool, arg5: u32, arg6: bool, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64) : bool {
        0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle::update<Weather<One>>(arg0, &mut 0x2::dynamic_field::borrow_mut<u32, CityWeatherOracle>(&mut arg1.id, arg2).weather, new<One>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16))
    }

    public fun add_city(arg0: &0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle::WriterCap, arg1: &mut WeatherOracle, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CityWeatherOracle{
            id      : 0x2::object::new(arg3),
            weather : 0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle::new<Weather<One>>(arg0, 1, empty<One>(), arg3),
        };
        0x2::dynamic_field::add<u32, CityWeatherOracle>(&mut arg1.id, arg2, v0);
    }

    public fun aggregate<T0, T1>(arg0: vector<Weather<T0>>) : Weather<T1> {
        let Weather {
            geoname_id         : v0,
            latitude           : v1,
            positive_latitude  : v2,
            longitude          : v3,
            positive_longitude : v4,
            weather_id         : v5,
            temp               : v6,
            pressure           : v7,
            humidity           : v8,
            visibility         : v9,
            wind_speed         : v10,
            wind_deg           : v11,
            wind_gust          : v12,
            clouds             : v13,
            dt                 : v14,
        } = 0x1::vector::pop_back<Weather<T0>>(&mut arg0);
        Weather<T1>{
            geoname_id         : v0,
            latitude           : v1,
            positive_latitude  : v2,
            longitude          : v3,
            positive_longitude : v4,
            weather_id         : v5,
            temp               : v6,
            pressure           : v7,
            humidity           : v8,
            visibility         : v9,
            wind_speed         : v10,
            wind_deg           : v11,
            wind_gust          : v12,
            clouds             : v13,
            dt                 : v14,
        }
    }

    public fun clouds<T0>(arg0: &Weather<T0>) : u64 {
        arg0.clouds
    }

    public fun dt<T0>(arg0: &Weather<T0>) : u64 {
        arg0.dt
    }

    public fun geoname_id<T0>(arg0: &Weather<T0>) : u32 {
        arg0.geoname_id
    }

    public fun humidity<T0>(arg0: &Weather<T0>) : u64 {
        arg0.humidity
    }

    fun init(arg0: WEATHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WEATHER>(arg0, arg1);
        let v0 = WeatherOracle{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<WeatherOracle>(v0);
        0x2::transfer::public_transfer<0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle::WriterCap>(0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle::writer(arg1), 0x2::tx_context::sender(arg1));
    }

    public fun pressure<T0>(arg0: &Weather<T0>) : u64 {
        arg0.pressure
    }

    public fun temp<T0>(arg0: &Weather<T0>) : u64 {
        arg0.temp
    }

    public fun visibility<T0>(arg0: &Weather<T0>) : u64 {
        arg0.visibility
    }

    public fun weather_id<T0>(arg0: &Weather<T0>) : u8 {
        arg0.weather_id
    }

    public fun wind_deg<T0>(arg0: &Weather<T0>) : u64 {
        arg0.wind_deg
    }

    public fun wind_gust<T0>(arg0: &Weather<T0>) : u64 {
        arg0.wind_gust
    }

    public fun wind_speed<T0>(arg0: &Weather<T0>) : u64 {
        arg0.wind_speed
    }

    // decompiled from Move bytecode v6
}

