module 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle {
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

    struct COMPOSITE_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct RATIO_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct CompositeSet has copy, drop {
        price_oracle: address,
        id: u8,
        ratio_id: u8,
    }

    struct CompositeRemoved has copy, drop {
        price_oracle: address,
        id: u8,
        ratio_id: u8,
    }

    public fun composite_ratio_id(arg0: &PriceOracle, arg1: u8) : u8 {
        let v0 = COMPOSITE_KEY{dummy_field: false};
        *0x2::table::borrow<u8, u8>(0x2::dynamic_field::borrow<COMPOSITE_KEY, 0x2::table::Table<u8, u8>>(&arg0.id, v0), arg1)
    }

    public fun create_caps(arg0: &OracleAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleAdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OracleAdminCap>(v0, arg1);
        let v1 = OracleFeederCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OracleFeederCap>(v1, arg1);
    }

    public fun create_feeder(arg0: &OracleAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun decimal(arg0: &mut PriceOracle, arg1: u8) : u8 {
        price_object(arg0, arg1).decimal
    }

    public fun destroy_feeder_cap(arg0: OracleFeederCap) {
        let OracleFeederCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_token_price(arg0: &0x2::clock::Clock, arg1: &PriceOracle, arg2: u8) : (bool, u256, u8) {
        version_verification(arg1);
        let (v0, v1, v2) = raw_token_price(arg0, arg1, arg2);
        if (is_ratio(arg1, arg2)) {
            return (false, v1, v2)
        };
        if (!is_composite(arg1, arg2)) {
            return (v0, v1, v2)
        };
        let (v3, v4, v5) = raw_token_price(arg0, arg1, composite_ratio_id(arg1, arg2));
        let v6 = v0 && v3;
        (v6, v1 * v4 / (0x2::math::pow(10, v5) as u256), v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PriceOracle{
            id              : 0x2::object::new(arg0),
            version         : 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_version::this_version(),
            update_interval : 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_constants::default_update_interval(),
            price_oracles   : 0x2::table::new<u8, Price>(arg0),
        };
        0x2::transfer::share_object<PriceOracle>(v1);
    }

    public fun is_composite(arg0: &PriceOracle, arg1: u8) : bool {
        let v0 = COMPOSITE_KEY{dummy_field: false};
        if (0x2::dynamic_field::exists_<COMPOSITE_KEY>(&arg0.id, v0)) {
            let v2 = COMPOSITE_KEY{dummy_field: false};
            0x2::table::contains<u8, u8>(0x2::dynamic_field::borrow<COMPOSITE_KEY, 0x2::table::Table<u8, u8>>(&arg0.id, v2), arg1)
        } else {
            false
        }
    }

    public fun is_ratio(arg0: &PriceOracle, arg1: u8) : bool {
        let v0 = RATIO_KEY{dummy_field: false};
        if (0x2::dynamic_field::exists_<RATIO_KEY>(&arg0.id, v0)) {
            let v2 = RATIO_KEY{dummy_field: false};
            0x2::table::contains<u8, u8>(0x2::dynamic_field::borrow<RATIO_KEY, 0x2::table::Table<u8, u8>>(&arg0.id, v2), arg1)
        } else {
            false
        }
    }

    public(friend) fun oracle_version_migrate(arg0: &OracleAdminCap, arg1: &mut PriceOracle) {
        assert!(arg1.version <= 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_version::this_version(), 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::not_available_version());
        arg1.version = 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_version::this_version();
    }

    public fun price_object(arg0: &PriceOracle, arg1: u8) : &Price {
        assert!(0x2::table::contains<u8, Price>(&arg0.price_oracles, arg1), 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::price_oracle_not_found());
        0x2::table::borrow<u8, Price>(&arg0.price_oracles, arg1)
    }

    fun raw_token_price(arg0: &0x2::clock::Clock, arg1: &PriceOracle, arg2: u8) : (bool, u256, u8) {
        let v0 = &arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::non_existent_oracle());
        let v1 = 0x2::table::borrow<u8, Price>(v0, arg2);
        let v2 = false;
        if (v1.value > 0 && 0x2::clock::timestamp_ms(arg0) - v1.timestamp <= arg1.update_interval) {
            v2 = true;
        };
        (v2, v1.value, v1.decimal)
    }

    public entry fun register_token_price(arg0: &OracleAdminCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: u8, arg4: u256, arg5: u8) {
        version_verification(arg2);
        assert!(arg5 <= 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_constants::default_decimal_limit() && arg5 > 0, 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::invalid_value());
        let v0 = &mut arg2.price_oracles;
        assert!(!0x2::table::contains<u8, Price>(v0, arg3), 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::oracle_already_exist());
        let v1 = Price{
            value     : arg4,
            decimal   : arg5,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<u8, Price>(v0, arg3, v1);
    }

    public entry fun remove_composite(arg0: &OracleAdminCap, arg1: &mut PriceOracle, arg2: u8) {
        version_verification(arg1);
        let v0 = COMPOSITE_KEY{dummy_field: false};
        let v1 = 0x2::table::remove<u8, u8>(0x2::dynamic_field::borrow_mut<COMPOSITE_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v0), arg2);
        let v2 = RATIO_KEY{dummy_field: false};
        0x2::table::remove<u8, u8>(0x2::dynamic_field::borrow_mut<RATIO_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v2), v1);
        let v3 = CompositeRemoved{
            price_oracle : 0x2::object::uid_to_address(&arg1.id),
            id           : arg2,
            ratio_id     : v1,
        };
        0x2::event::emit<CompositeRemoved>(v3);
    }

    public fun safe_decimal(arg0: &PriceOracle, arg1: u8) : u8 {
        price_object(arg0, arg1).decimal
    }

    public entry fun set_composite(arg0: &OracleAdminCap, arg1: &mut PriceOracle, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        version_verification(arg1);
        assert!(0x2::table::contains<u8, Price>(&arg1.price_oracles, arg2) && 0x2::table::contains<u8, Price>(&arg1.price_oracles, arg3), 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::non_existent_oracle());
        let v0 = if (arg2 != arg3) {
            if (!is_ratio(arg1, arg2)) {
                if (!is_composite(arg1, arg3)) {
                    !is_ratio(arg1, arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::invalid_value());
        assert!(arg2 < 200 && arg3 >= 200, 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::invalid_value());
        let v1 = COMPOSITE_KEY{dummy_field: false};
        if (!0x2::dynamic_field::exists_<COMPOSITE_KEY>(&arg1.id, v1)) {
            let v2 = COMPOSITE_KEY{dummy_field: false};
            0x2::dynamic_field::add<COMPOSITE_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v2, 0x2::table::new<u8, u8>(arg4));
            let v3 = RATIO_KEY{dummy_field: false};
            0x2::dynamic_field::add<RATIO_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v3, 0x2::table::new<u8, u8>(arg4));
        };
        let v4 = COMPOSITE_KEY{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<COMPOSITE_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v4);
        if (0x2::table::contains<u8, u8>(v5, arg2)) {
            let v6 = RATIO_KEY{dummy_field: false};
            0x2::table::remove<u8, u8>(0x2::dynamic_field::borrow_mut<RATIO_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v6), 0x2::table::remove<u8, u8>(v5, arg2));
            let v7 = COMPOSITE_KEY{dummy_field: false};
            0x2::table::add<u8, u8>(0x2::dynamic_field::borrow_mut<COMPOSITE_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v7), arg2, arg3);
        } else {
            0x2::table::add<u8, u8>(v5, arg2, arg3);
        };
        let v8 = RATIO_KEY{dummy_field: false};
        0x2::table::add<u8, u8>(0x2::dynamic_field::borrow_mut<RATIO_KEY, 0x2::table::Table<u8, u8>>(&mut arg1.id, v8), arg3, arg2);
        let v9 = CompositeSet{
            price_oracle : 0x2::object::uid_to_address(&arg1.id),
            id           : arg2,
            ratio_id     : arg3,
        };
        0x2::event::emit<CompositeSet>(v9);
    }

    public entry fun set_update_interval(arg0: &OracleAdminCap, arg1: &mut PriceOracle, arg2: u64) {
        version_verification(arg1);
        assert!(arg2 > 0, 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::invalid_value());
        arg1.update_interval = arg2;
    }

    public(friend) fun update_price(arg0: &0x2::clock::Clock, arg1: &mut PriceOracle, arg2: u8, arg3: u256) {
        version_verification(arg1);
        let v0 = &mut arg1.price_oracles;
        assert!(0x2::table::contains<u8, Price>(v0, arg2), 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_error::non_existent_oracle());
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

    public entry fun update_token_price(arg0: &OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: u8, arg4: u256) {
        abort 0
    }

    public entry fun update_token_price_batch(arg0: &OracleFeederCap, arg1: &0x2::clock::Clock, arg2: &mut PriceOracle, arg3: vector<u8>, arg4: vector<u256>) {
        abort 0
    }

    entry fun version_migrate(arg0: &OracleAdminCap, arg1: &mut PriceOracle) {
        abort 0
    }

    fun version_verification(arg0: &PriceOracle) {
        0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle_version::pre_check_version(arg0.version);
    }

    // decompiled from Move bytecode v7
}

