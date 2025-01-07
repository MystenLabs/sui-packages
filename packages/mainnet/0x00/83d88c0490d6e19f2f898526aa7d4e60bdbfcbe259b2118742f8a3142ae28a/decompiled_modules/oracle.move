module 0x83d88c0490d6e19f2f898526aa7d4e60bdbfcbe259b2118742f8a3142ae28a::oracle {
    struct OracleCap has key {
        id: 0x2::object::UID,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        price_oracles: 0x2::table::Table<0x1::ascii::String, Price>,
    }

    struct Price has store {
        value: u256,
        decimal: u8,
    }

    public fun get_timestamp(arg0: &0x2::clock::Clock) : u256 {
        ((0x2::clock::timestamp_ms(arg0) / 1000) as u256)
    }

    public fun get_token_price<T0>(arg0: &PriceOracle, arg1: address) : (u256, u8) {
        let v0 = &arg0.price_oracles;
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, Price>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::ascii::String, Price>(v0, v1);
        (v2.value, v2.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id            : 0x2::object::new(arg0),
            price_oracles : 0x2::table::new<0x1::ascii::String, Price>(arg0),
        };
        0x2::transfer::share_object<PriceOracle>(v0);
        let v1 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OracleCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_token_price<T0>(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: u256, arg3: u8) {
        let v0 = &mut arg1.price_oracles;
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::table::contains<0x1::ascii::String, Price>(v0, v1), 1);
        let v2 = Price{
            value   : arg2,
            decimal : arg3,
        };
        0x2::table::add<0x1::ascii::String, Price>(v0, v1, v2);
    }

    public entry fun update_token_price<T0>(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: u256) {
        let v0 = &mut arg1.price_oracles;
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, Price>(v0, v1), 0);
        0x2::table::borrow_mut<0x1::ascii::String, Price>(v0, v1).value = arg2;
    }

    // decompiled from Move bytecode v6
}

