module 0x36e57885c0fd536f1380cf34993332a2582f1d3a47c923403f1d5a766e9200a3::oracle {
    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleFeederCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        update_interval: u64,
        price_oracles: 0x2::table::Table<u8, Price>,
    }

    struct Price has store {
        value: u256,
        decimal: u8,
        timestamp: u64,
    }

    public fun get_token_price(arg0: &0x2::clock::Clock, arg1: &PriceOracle, arg2: u8) : (bool, u256, u8) {
        version_verification(arg1);
        let v0 = &arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 50003);
        let v1 = 0x2::table::borrow<u8, Price>(v0, arg2);
        (0x2::clock::timestamp_ms(arg0) <= v1.timestamp + arg1.update_interval, v1.value, v1.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OracleFeederCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleFeederCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = PriceOracle{
            id              : 0x2::object::new(arg0),
            version         : 1,
            update_interval : 30000,
            price_oracles   : 0x2::table::new<u8, Price>(arg0),
        };
        0x2::transfer::share_object<PriceOracle>(v2);
    }

    public entry fun register_token_price(arg0: &OracleAdminCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: u8, arg4: u256, arg5: u8) {
        version_verification(arg2);
        let v0 = &mut arg2.price_oracles;
        assert!(!0x2::table::contains<u8, Price>(v0, arg3), 50004);
        let v1 = Price{
            value     : arg4,
            decimal   : arg5,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<u8, Price>(v0, arg3, v1);
    }

    public entry fun set_update_interval(arg0: &OracleAdminCap, arg1: &mut PriceOracle, arg2: u64) {
        version_verification(arg1);
        arg1.update_interval = arg2;
    }

    public entry fun update_token_price(arg0: &OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: u8, arg4: u256) {
        version_verification(arg2);
        let v0 = &mut arg2.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg3), 50003);
        let v1 = 0x2::table::borrow_mut<u8, Price>(v0, arg3);
        v1.value = arg4;
        v1.timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public entry fun update_token_price_batch(arg0: &OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: vector<u8>, arg4: vector<u256>) {
        version_verification(arg2);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 == 0x1::vector::length<u256>(&arg4), 50002);
        let v1 = 0;
        while (v1 < v0) {
            update_token_price(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&arg3, v1), *0x1::vector::borrow<u256>(&arg4, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun version_migrate(arg0: &OracleAdminCap, arg1: &mut PriceOracle) {
        assert!(arg1.version < 1, 50001);
        arg1.version = 1;
    }

    fun version_verification(arg0: &PriceOracle) {
        assert!(arg0.version == 1, 50000);
    }

    // decompiled from Move bytecode v6
}

