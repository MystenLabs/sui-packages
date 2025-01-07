module 0x79db1ef58c455db20236e6ee19daacd9c17f840b3b9617dc2ec3cf58df28cdfc::game {
    struct Fist has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        remainder: u32,
    }

    struct Record has key {
        id: 0x2::object::UID,
        player: 0x1::string::String,
        opponent: 0x1::string::String,
        result: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Fist{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"stone"),
            remainder : 0,
        };
        0x2::transfer::share_object<Fist>(v0);
        let v1 = Fist{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"paper"),
            remainder : 1,
        };
        0x2::transfer::share_object<Fist>(v1);
        let v2 = Fist{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"scissors"),
            remainder : 2,
        };
        0x2::transfer::share_object<Fist>(v2);
    }

    public entry fun make_fist(arg0: &Fist, arg1: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = random(arg1) % 3;
        let v1 = 0x1::string::utf8(b"win");
        let v2 = b"stone";
        if (arg0.remainder == v0) {
            v1 = 0x1::string::utf8(b"tie");
        } else if ((arg0.remainder + 1) % 3 == v0) {
            v1 = 0x1::string::utf8(b"lose");
        };
        if (v0 == 1) {
            v2 = b"paper";
        } else if (v0 == 2) {
            v2 = b"scissors";
        };
        let v3 = Record{
            id       : 0x2::object::new(arg2),
            player   : arg0.name,
            opponent : 0x1::string::utf8(v2),
            result   : v1,
        };
        0x2::transfer::transfer<Record>(v3, 0x2::tx_context::sender(arg2));
    }

    fun random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle) : u32 {
        0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_temp(arg0, 1853909)
    }

    // decompiled from Move bytecode v6
}

