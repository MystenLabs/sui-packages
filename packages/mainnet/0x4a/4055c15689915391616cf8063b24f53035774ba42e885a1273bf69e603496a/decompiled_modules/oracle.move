module 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle {
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

    struct PriceUpdated has copy, drop {
        price_oracle: address,
        id: u8,
        price: u256,
        last_price: u256,
        update_at: u64,
        last_update_at: u64,
    }

    public fun create_feeder(arg0: &OracleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleFeederCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OracleFeederCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun decimal(arg0: &mut PriceOracle, arg1: u8) : u8 {
        price_object(arg0, arg1).decimal
    }

    public fun get_token_price(arg0: &0x2::clock::Clock, arg1: &PriceOracle, arg2: u8) : (bool, u256, u8) {
        version_verification(arg1);
        let v0 = &arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::non_existent_oracle());
        let v1 = 0x2::table::borrow<u8, Price>(v0, arg2);
        let v2 = false;
        if (v1.value > 0 && 0x2::clock::timestamp_ms(arg0) - v1.timestamp <= arg1.update_interval) {
            v2 = true;
        };
        (v2, v1.value, v1.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OracleFeederCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleFeederCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = PriceOracle{
            id              : 0x2::object::new(arg0),
            version         : 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_version::this_version(),
            update_interval : 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_constants::default_update_interval(),
            price_oracles   : 0x2::table::new<u8, Price>(arg0),
        };
        0x2::transfer::share_object<PriceOracle>(v2);
    }

    public(friend) fun oracle_version_migrate(arg0: &OracleAdminCap, arg1: &mut PriceOracle) {
        assert!(arg1.version < 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_version::this_version(), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::not_available_version());
        arg1.version = 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_version::this_version();
    }

    public fun price_object(arg0: &PriceOracle, arg1: u8) : &Price {
        assert!(0x2::table::contains<u8, Price>(&arg0.price_oracles, arg1), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::price_oracle_not_found());
        0x2::table::borrow<u8, Price>(&arg0.price_oracles, arg1)
    }

    public entry fun register_token_price(arg0: &OracleAdminCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: u8, arg4: u256, arg5: u8) {
        version_verification(arg2);
        let v0 = &mut arg2.price_oracles;
        assert!(!0x2::table::contains<u8, Price>(v0, arg3), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::oracle_already_exist());
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

    public(friend) fun update_price(arg0: &0x2::clock::Clock, arg1: &mut PriceOracle, arg2: u8, arg3: u256) {
        version_verification(arg1);
        let v0 = &mut arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::non_existent_oracle());
        let v1 = 0x2::table::borrow_mut<u8, Price>(v0, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = PriceUpdated{
            price_oracle   : 0x2::object::uid_to_address(&arg1.id),
            id             : arg2,
            price          : arg3,
            last_price     : v1.value,
            update_at      : v2,
            last_update_at : v1.timestamp,
        };
        0x2::event::emit<PriceUpdated>(v3);
        v1.value = arg3;
        v1.timestamp = v2;
    }

    public(friend) fun update_price_batch(arg0: &0x2::clock::Clock, arg1: &mut PriceOracle, arg2: vector<u8>, arg3: vector<u256>) {
        assert!(0x1::vector::length<u8>(&arg2) == 0x1::vector::length<u256>(&arg3), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::price_length_not_match());
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg2)) {
            update_price(arg0, arg1, *0x1::vector::borrow<u8>(&arg2, v0), *0x1::vector::borrow<u256>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun update_token_price(arg0: &OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: u8, arg4: u256) {
        version_verification(arg2);
        let v0 = &mut arg2.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg3), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::non_existent_oracle());
        let v1 = 0x2::table::borrow_mut<u8, Price>(v0, arg3);
        v1.value = arg4;
        v1.timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public entry fun update_token_price_batch(arg0: &OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: vector<u8>, arg4: vector<u256>) {
        version_verification(arg2);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 == 0x1::vector::length<u256>(&arg4), 0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_error::price_length_not_match());
        let v1 = 0;
        while (v1 < v0) {
            update_token_price(arg0, arg1, arg2, *0x1::vector::borrow<u8>(&arg3, v1), *0x1::vector::borrow<u256>(&arg4, v1));
            v1 = v1 + 1;
        };
    }

    entry fun version_migrate(arg0: &OracleAdminCap, arg1: &mut PriceOracle) {
        abort 0
    }

    fun version_verification(arg0: &PriceOracle) {
        0x4a4055c15689915391616cf8063b24f53035774ba42e885a1273bf69e603496a::oracle_version::pre_check_version(arg0.version);
    }

    // decompiled from Move bytecode v6
}

