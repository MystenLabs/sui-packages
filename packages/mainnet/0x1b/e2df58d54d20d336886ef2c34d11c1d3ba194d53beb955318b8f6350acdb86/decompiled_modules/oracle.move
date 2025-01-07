module 0x1be2df58d54d20d336886ef2c34d11c1d3ba194d53beb955318b8f6350acdb86::oracle {
    struct OracleCap has key {
        id: 0x2::object::UID,
        owner: 0x2::table::Table<address, bool>,
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
        let v1 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v1, 0x2::tx_context::sender(arg0), true);
        let v2 = OracleCap{
            id     : 0x2::object::new(arg0),
            owner  : v1,
            feeder : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<OracleCap>(v2);
    }

    fun only_feeder(arg0: &OracleCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.feeder, v0), 50002);
        assert!(*0x2::table::borrow<address, bool>(&arg0.feeder, v0), 50002);
    }

    fun only_owner(arg0: &OracleCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.owner, v0), 50001);
        assert!(*0x2::table::borrow<address, bool>(&arg0.owner, v0), 50001);
    }

    public entry fun register_token_price(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: u8, arg3: u256, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg5);
        let v0 = &mut arg1.price_oracles;
        assert!(!0x2::table::contains<u8, Price>(v0, arg2), 50001);
        let v1 = Price{
            value   : arg3,
            decimal : arg4,
        };
        0x2::table::add<u8, Price>(v0, arg2, v1);
    }

    public fun set_feeder(arg0: &mut OracleCap, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg3);
        if (!0x2::table::contains<address, bool>(&arg0.feeder, arg1)) {
            if (arg2) {
                0x2::table::add<address, bool>(&mut arg0.feeder, arg1, arg2);
            };
        } else if (!arg2) {
            0x2::table::remove<address, bool>(&mut arg0.feeder, arg1);
        };
    }

    public fun set_owner(arg0: &mut OracleCap, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg3);
        if (!0x2::table::contains<address, bool>(&arg0.owner, arg1)) {
            if (arg2) {
                0x2::table::add<address, bool>(&mut arg0.owner, arg1, arg2);
            };
        } else if (!arg2) {
            0x2::table::remove<address, bool>(&mut arg0.owner, arg1);
        };
    }

    public entry fun update_token_price(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: u8, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        only_feeder(arg0, arg4);
        let v0 = &mut arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 50000);
        0x2::table::borrow_mut<u8, Price>(v0, arg2).value = arg3;
    }

    public entry fun update_token_price_batch(arg0: &OracleCap, arg1: &mut PriceOracle, arg2: vector<u8>, arg3: vector<u256>, arg4: &mut 0x2::tx_context::TxContext) {
        only_feeder(arg0, arg4);
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 == 0x1::vector::length<u256>(&arg3), 50003);
        let v1 = 0;
        let v2 = &mut arg1.price_oracles;
        while (v1 < v0) {
            let v3 = 0x1::vector::borrow<u8>(&arg2, v1);
            assert!(0x2::table::contains<u8, Price>(v2, *v3), 50000);
            0x2::table::borrow_mut<u8, Price>(v2, *v3).value = *0x1::vector::borrow<u256>(&arg3, v1);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

