module 0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::oracle_ag {
    struct OracleAggregator has key {
        id: 0x2::object::UID,
        pyth_price_id_table: 0x2::table::Table<0x1::ascii::String, vector<u8>>,
        coin_decimal_registry: 0x2::table::Table<0x1::ascii::String, u8>,
        max_age: u64,
        coin_config: 0x2::table::Table<0x1::ascii::String, u64>,
    }

    struct OracleAggregatorCap has store, key {
        id: 0x2::object::UID,
        oracle_aggregator: 0x2::object::ID,
    }

    struct ORACLE_AG has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (OracleAggregator, OracleAggregatorCap) {
        let v0 = OracleAggregator{
            id                    : 0x2::object::new(arg0),
            pyth_price_id_table   : 0x2::table::new<0x1::ascii::String, vector<u8>>(arg0),
            coin_decimal_registry : 0x2::table::new<0x1::ascii::String, u8>(arg0),
            max_age               : 0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::consts::GET_PYTH_MAX_AGE(),
            coin_config           : 0x2::table::new<0x1::ascii::String, u64>(arg0),
        };
        let v1 = OracleAggregatorCap{
            id                : 0x2::object::new(arg0),
            oracle_aggregator : 0x2::object::id<OracleAggregator>(&v0),
        };
        (v0, v1)
    }

    public fun GET_CPYTH_PRICE() : u64 {
        1024
    }

    public fun GET_CZERO_VALUE() : u64 {
        1
    }

    public fun assert_oracle_aggregator_cap(arg0: &OracleAggregator, arg1: &OracleAggregatorCap) {
        assert!(0x2::object::id<OracleAggregator>(arg0) == arg1.oracle_aggregator, 9223372260193075199);
    }

    public fun assert_price_object_type<T0>(arg0: &OracleAggregator, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, vector<u8>>(&arg0.pyth_price_id_table, v0), 0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == *0x2::table::borrow<0x1::ascii::String, vector<u8>>(&arg0.pyth_price_id_table, v0), 0);
    }

    public fun calc_usd_value<T0>(arg0: &OracleAggregator, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert_price_object_type<T0>(arg0, arg1);
        let (v0, v1, _) = get_price<T0>(arg0, arg1, arg3);
        (0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::lotus_math::scale_from_float(0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::lotus_math::mul_u128(0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::lotus_math::scale_to_float((arg2 as u128), (get_coin_decimal<T0>(arg0) as u64)), 0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::lotus_math::scale_to_float((v0 as u128), v1)), 0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::consts::GET_USDC_DECIMALS()) as u64)
    }

    public fun get_coin_decimal<T0>(arg0: &OracleAggregator) : u8 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, u8>(&arg0.coin_decimal_registry, v0), 0);
        *0x2::table::borrow<0x1::ascii::String, u8>(&arg0.coin_decimal_registry, v0)
    }

    public fun get_price<T0>(arg0: &OracleAggregator, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        if (*0x2::table::borrow<0x1::ascii::String, u64>(&arg0.coin_config, 0x1::type_name::into_string(0x1::type_name::get<T0>())) & 1 > 0) {
            return (0, 0, 0)
        };
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, arg0.max_age);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, vector<u8>>(&arg0.pyth_price_id_table, v3), 0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == *0x2::table::borrow<0x1::ascii::String, vector<u8>>(&arg0.pyth_price_id_table, v3), 0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let (v6, v7) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5) == true) {
            let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4);
            assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) < v8 * 0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::consts::GET_MAX_PRICE_CONF_BPS() / 10000, 2);
            (v8, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5))
        } else {
            let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u8));
            assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) < v9 * 0x73393c79f2179f63769a36ec08b467b3f24aa8a8773e79c56114c3f1b79bc8b1::consts::GET_MAX_PRICE_CONF_BPS() / 10000, 2);
            (v9, 0)
        };
        (v6, v7, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0))
    }

    public fun get_pyth_address<T0>(arg0: &OracleAggregator) : vector<u8> {
        *0x2::table::borrow<0x1::ascii::String, vector<u8>>(&arg0.pyth_price_id_table, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun init(arg0: ORACLE_AG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        0x2::transfer::share_object<OracleAggregator>(v0);
        0x2::transfer::transfer<OracleAggregatorCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<ORACLE_AG>(arg0, arg1);
    }

    public fun update_coin_config<T0>(arg0: &mut OracleAggregator, arg1: &OracleAggregatorCap, arg2: u64) {
        assert_oracle_aggregator_cap(arg0, arg1);
        if (!0x2::table::contains<0x1::ascii::String, u64>(&arg0.coin_config, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg0.coin_config, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
        } else {
            *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.coin_config, 0x1::type_name::into_string(0x1::type_name::get<T0>())) = arg2;
        };
    }

    public fun update_coin_decimal<T0>(arg0: &mut OracleAggregator, arg1: &OracleAggregatorCap, arg2: u8) {
        assert_oracle_aggregator_cap(arg0, arg1);
        if (!0x2::table::contains<0x1::ascii::String, u8>(&arg0.coin_decimal_registry, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) {
            0x2::table::add<0x1::ascii::String, u8>(&mut arg0.coin_decimal_registry, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
        };
        *0x2::table::borrow_mut<0x1::ascii::String, u8>(&mut arg0.coin_decimal_registry, 0x1::type_name::into_string(0x1::type_name::get<T0>())) = arg2;
    }

    public fun update_pyth_price_id<T0>(arg0: &mut OracleAggregator, arg1: &OracleAggregatorCap, arg2: vector<u8>) {
        assert_oracle_aggregator_cap(arg0, arg1);
        if (!0x2::table::contains<0x1::ascii::String, vector<u8>>(&arg0.pyth_price_id_table, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) {
            0x2::table::add<0x1::ascii::String, vector<u8>>(&mut arg0.pyth_price_id_table, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
        } else {
            *0x2::table::borrow_mut<0x1::ascii::String, vector<u8>>(&mut arg0.pyth_price_id_table, 0x1::type_name::into_string(0x1::type_name::get<T0>())) = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

