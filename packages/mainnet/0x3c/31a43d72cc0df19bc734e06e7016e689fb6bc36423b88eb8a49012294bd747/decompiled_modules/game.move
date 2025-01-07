module 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct CorbaGameFi has key {
        id: 0x2::object::UID,
        version: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct CorbaPlayer has store, key {
        id: 0x2::object::UID,
        level: u16,
        exp: u32,
        max_exp: u32,
        gold: u32,
        wood: u32,
        meat: u32,
    }

    struct LoadPlayerEvent has copy, drop {
        id: 0x2::object::ID,
        level: u16,
        exp: u32,
        max_exp: u32,
        gold: u32,
        wood: u32,
        meat: u32,
    }

    struct Hero has store, key {
        id: 0x2::object::UID,
        type_hero: u16,
        health: u16,
        max_health: u16,
        damage: u16,
        speed: u16,
        level: u16,
        exp: u16,
        max_exp: u16,
        location_x: u16,
        location_y: u16,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NewHeroEvent has copy, drop {
        id: 0x2::object::ID,
        hero_id: 0x2::object::ID,
        owner: address,
    }

    struct CityWeatherEvent has copy, drop {
        id: u32,
        city_name: 0x1::string::String,
        country: 0x1::string::String,
        temp: u32,
        visibility: u16,
        wind_speed: u16,
        wind_deg: 0x1::string::String,
        clouds: u8,
        is_rain: bool,
        rain_fall: 0x1::string::String,
    }

    struct GAME has drop {
        dummy_field: bool,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    public entry fun get_city_weather(arg0: u32, arg1: &0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::WeatherOracle) {
        let v0 = CityWeatherEvent{
            id         : arg0,
            city_name  : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_name(arg1, arg0),
            country    : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_country(arg1, arg0),
            temp       : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_temp(arg1, arg0),
            visibility : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_visibility(arg1, arg0),
            wind_speed : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_wind_speed(arg1, arg0),
            wind_deg   : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_wind_deg(arg1, arg0),
            clouds     : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_clouds(arg1, arg0),
            is_rain    : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_is_rain(arg1, arg0),
            rain_fall  : 0x3c31a43d72cc0df19bc734e06e7016e689fb6bc36423b88eb8a49012294bd747::weather::city_weather_oracle_rain_fall(arg1, arg0),
        };
        0x2::event::emit<CityWeatherEvent>(v0);
    }

    public fun get_level(arg0: &mut Hero) : u16 {
        arg0.level
    }

    public entry fun get_player_data(arg0: &mut CorbaGameFi, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<0x2::object::ID>(&mut arg0.id, 0x2::object::id_from_address(0x2::tx_context::sender(arg1)))) {
            let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, CorbaPlayer>(&mut arg0.id, 0x2::object::id_from_address(0x2::tx_context::sender(arg1)));
            let v1 = LoadPlayerEvent{
                id      : 0x2::object::uid_to_inner(&v0.id),
                level   : v0.level,
                exp     : v0.exp,
                max_exp : v0.max_exp,
                gold    : v0.gold,
                wood    : v0.wood,
                meat    : v0.meat,
            };
            0x2::event::emit<LoadPlayerEvent>(v1);
        } else {
            new_player(arg0, arg1);
        };
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = CorbaGameFi{
            id          : 0x2::object::new(arg1),
            version     : 0x1::string::utf8(b"1.0"),
            description : 0x1::string::utf8(b"Corba game"),
        };
        0x2::transfer::share_object<CorbaGameFi>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, @0x8d9f68271c525e6a35d75bc7afb552db1bf2f44bb65e860b356e08187cb9fa3d);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<GAME>(arg0, arg1), @0x8d9f68271c525e6a35d75bc7afb552db1bf2f44bb65e860b356e08187cb9fa3d);
    }

    public fun mint_hero(arg0: u16, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::url::Url, arg9: &mut 0x2::tx_context::TxContext) : Hero {
        Hero{
            id          : 0x2::object::new(arg9),
            type_hero   : arg0,
            health      : arg1,
            max_health  : arg1,
            damage      : arg2,
            speed       : arg3,
            level       : 1,
            exp         : 0,
            max_exp     : arg5,
            location_x  : 0,
            location_y  : 0,
            name        : arg6,
            description : arg7,
            url         : arg8,
        }
    }

    public entry fun new_herro(arg0: u16, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::ascii::String, arg9: &mut CorbaGameFi, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&mut arg9.id, 0x2::object::id_from_address(0x2::tx_context::sender(arg10))), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, CorbaPlayer>(&mut arg9.id, 0x2::object::id_from_address(0x2::tx_context::sender(arg10)));
        let (v1, v2, v3) = if (arg0 == 0) {
            (10, 10, 10)
        } else if (arg0 == 1) {
            (10, 10, 10)
        } else {
            assert!(arg0 == 2, 4);
            (10, 10, 10)
        };
        assert!(v0.meat >= v2 && v0.gold >= v1 && v0.wood >= v3, 1);
        v0.meat = v0.meat - v2;
        v0.gold = v0.gold - v1;
        v0.wood = v0.wood - v3;
        let v4 = mint_hero(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::url::new_unsafe(arg8), arg10);
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        0x2::transfer::public_transfer<Hero>(v4, 0x2::tx_context::sender(arg10));
        let v6 = NewHeroEvent{
            id      : v5,
            hero_id : v5,
            owner   : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<NewHeroEvent>(v6);
    }

    public fun new_player(arg0: &mut CorbaGameFi, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        let v1 = CorbaPlayer{
            id      : 0x2::object::new(arg1),
            level   : 1,
            exp     : 0,
            max_exp : 5,
            gold    : 100,
            wood    : 100,
            meat    : 100,
        };
        let v2 = LoadPlayerEvent{
            id      : 0x2::object::uid_to_inner(&v1.id),
            level   : 1,
            exp     : 0,
            max_exp : 5,
            gold    : 100,
            wood    : 100,
            meat    : 100,
        };
        0x2::event::emit<LoadPlayerEvent>(v2);
        0x2::dynamic_object_field::add<0x2::object::ID, CorbaPlayer>(&mut arg0.id, 0x2::object::id_from_address(0x2::tx_context::sender(arg1)), v1);
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_hero(arg0: u16, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: &mut Hero, arg10: &mut 0x2::tx_context::TxContext) {
        arg9.location_x = arg0;
        arg9.location_y = arg1;
        arg9.max_health = arg3;
        arg9.health = arg2;
        arg9.damage = arg4;
        arg9.speed = arg5;
        arg9.level = arg6;
        arg9.exp = arg7;
        arg9.max_exp = arg8;
    }

    public entry fun update_player_level(arg0: u16, arg1: u32, arg2: u32, arg3: &mut CorbaGameFi, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, CorbaPlayer>(&mut arg3.id, 0x2::object::id_from_address(0x2::tx_context::sender(arg4)));
        v0.level = arg0;
        v0.max_exp = arg2;
        v0.exp = arg1;
    }

    public entry fun update_player_resources(arg0: u32, arg1: u32, arg2: u32, arg3: &mut CorbaGameFi, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, CorbaPlayer>(&mut arg3.id, 0x2::object::id_from_address(0x2::tx_context::sender(arg4)));
        v0.gold = arg0;
        v0.meat = arg1;
        v0.wood = arg2;
    }

    // decompiled from Move bytecode v6
}

