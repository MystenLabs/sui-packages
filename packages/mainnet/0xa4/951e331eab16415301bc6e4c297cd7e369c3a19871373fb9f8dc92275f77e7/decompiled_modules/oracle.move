module 0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle {
    struct OracleCap has key {
        id: 0x2::object::UID,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        price_oracles: 0x2::table::Table<u8, Price>,
    }

    struct Price has store {
        value: u256,
        decimal: u8,
    }

    public fun get_token_price(arg0: &PriceOracle, arg1: u8) : (u256, u8) {
        let v0 = &arg0.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg1), 50000);
        let v1 = 0x2::table::borrow<u8, Price>(v0, arg1);
        (v1.value, v1.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id            : 0x2::object::new(arg0),
            price_oracles : 0x2::table::new<u8, Price>(arg0),
        };
        0x2::transfer::share_object<PriceOracle>(v0);
        let v1 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OracleCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_token_price(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: u8, arg3: u256, arg4: u8) {
        let v0 = &mut arg1.price_oracles;
        assert!(!0x2::table::contains<u8, Price>(v0, arg2), 50001);
        let v1 = Price{
            value   : arg3,
            decimal : arg4,
        };
        0x2::table::add<u8, Price>(v0, arg2, v1);
    }

    public entry fun update_token_price(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: u8, arg3: u256) {
        let v0 = &mut arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 50000);
        0x2::table::borrow_mut<u8, Price>(v0, arg2).value = arg3;
    }

    // decompiled from Move bytecode v6
}

