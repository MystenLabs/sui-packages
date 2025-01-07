module 0x8e6104c26fb316451b8dec58eca9827fb2953eb5293f2b996ef4f94d83f2fb0b::oracle {
    struct OracleCap has key {
        id: 0x2::object::UID,
        feeder: 0x2::table::Table<address, bool>,
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
        let v1 = OracleCap{
            id     : 0x2::object::new(arg0),
            feeder : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::transfer<OracleCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun only_feeder(arg0: &OracleCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.feeder, v0), 50001);
        assert!(*0x2::table::borrow<address, bool>(&arg0.feeder, v0), 50001);
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

    public fun set_feeder(arg0: &mut OracleCap, arg1: address, arg2: bool) {
        if (!0x2::table::contains<address, bool>(&arg0.feeder, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.feeder, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.feeder, arg1) = arg2;
        };
    }

    public entry fun update_token_price(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: u8, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        only_feeder(arg0, arg4);
        let v0 = &mut arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 50000);
        0x2::table::borrow_mut<u8, Price>(v0, arg2).value = arg3;
    }

    // decompiled from Move bytecode v6
}

