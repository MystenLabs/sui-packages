module 0xe7eddf0041f423643fd8ee2a01eba4462b1b438e88bf99653b6337f102bb3e02::pyth_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct PythRuleConfig has key {
        id: 0x2::object::UID,
        identifier_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>,
    }

    fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2))
    }

    fun err_invalid_price_info_object() {
        abort 1
    }

    fun err_unsupported_coin_type() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythRuleConfig{
            id             : 0x2::object::new(arg0),
            identifier_map : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u8>>(),
        };
        0x2::transfer::share_object<PythRuleConfig>(v0);
    }

    fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun remove_identifier<T0>(arg0: &mut PythRuleConfig, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.identifier_map, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u8>>(&mut arg0.identifier_map, &v0);
        };
    }

    public fun set_identifier<T0>(arg0: &mut PythRuleConfig, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::AdminCap, arg2: vector<u8>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.identifier_map, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<u8>>(&mut arg0.identifier_map, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<u8>>(&mut arg0.identifier_map, v0, arg2);
        };
    }

    public fun update_price<T0>(arg0: &PythRuleConfig, arg1: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.identifier_map, &v0)) {
            err_unsupported_coin_type();
        };
        if (0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4) != 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg3, *0x2::vec_map::get<0x1::type_name::TypeName, vector<u8>>(&arg0.identifier_map, &v0))) {
            err_invalid_price_info_object();
        };
        let (v1, v2) = get_price(arg3, arg4, arg2);
        let v3 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<T0>(arg1);
        let v4 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<T0, Rule>(v3, v4, arg2, mul_and_div(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<T0>(v3), v1, 0x1::u64::pow(10, (v2 as u8))));
    }

    // decompiled from Move bytecode v6
}

