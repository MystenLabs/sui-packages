module 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle {
    struct ORACLE has drop {
        dummy_field: bool,
    }

    struct Oracle has copy, drop, store {
        dummy_field: bool,
    }

    struct PythOracleKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PythOracle has store, key {
        id: 0x2::object::UID,
    }

    struct CoinDataKey has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinData has store, key {
        id: 0x2::object::UID,
        price_id: vector<u8>,
        max_age_seconds: u64,
    }

    struct PythOracleCreatedEvent has copy, drop {
        actor: address,
        oracle_id: 0x2::object::ID,
    }

    struct OracleCoinDataUpsertedEvent has copy, drop {
        actor: address,
        coin_type: 0x1::type_name::TypeName,
        price_id: vector<u8>,
        max_age_seconds: u64,
        was_created: bool,
    }

    public fun GET_CPYTH_PRICE() : u64 {
        1024
    }

    public fun GET_CZERO_VALUE() : u64 {
        1
    }

    public fun admin_create_pyth_oracle_and_add_to_sweethouse(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_pyth_oracle_and_add_to_sweethouse_internal(arg0, arg2);
    }

    public fun admin_set_coin_data<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        set_coin_data_internal<T0>(arg0, arg2, arg3, arg4);
    }

    fun create_pyth_oracle_and_add_to_sweethouse_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PythOracle{id: 0x2::object::new(arg1)};
        let v1 = Oracle{dummy_field: false};
        let v2 = PythOracleKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<Oracle, PythOracleKey, PythOracle>(arg0, v1, v2, v0);
        let v3 = PythOracleCreatedEvent{
            actor     : 0x2::tx_context::sender(arg1),
            oracle_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<PythOracleCreatedEvent>(v3);
    }

    public fun get_adjusted_price_or_zero(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float {
        if (!has_coin_data(get_pyth_oracle(arg0), arg1)) {
            return 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        };
        let (v0, v1, v2) = get_usd_price(arg0, arg1, arg2);
        let v3 = v0;
        let v4 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (v2 > v4) {
            return 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        };
        if (v4 - v2 >= get_max_age_seconds(arg0, arg1)) {
            return 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        };
        if (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_negative(&v3)) {
            return 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        };
        let v5 = price_lower_bound(v3, v1);
        if (!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive(&v5)) {
            return 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        };
        v5
    }

    public fun get_checked_usd_price(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, u64) {
        let (v0, v1, v2) = get_usd_price(arg0, arg1, arg2);
        let v3 = v0;
        let v4 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v2 <= v4, 13835341037792526339);
        assert!(v4 - v2 < get_max_age_seconds(arg0, arg1), 13835341050677428227);
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_negative(&v3), 13835341054972395523);
        let v5 = price_lower_bound(v3, v1);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive(&v5), 13835622542834139141);
        (v3, v1, v2)
    }

    fun get_coin_data(arg0: &PythOracle, arg1: 0x1::type_name::TypeName) : &CoinData {
        let v0 = CoinDataKey{coin_type: arg1};
        assert!(0x2::dynamic_object_field::exists_<CoinDataKey>(&arg0.id, v0), 13836184496355278855);
        0x2::dynamic_object_field::borrow<CoinDataKey, CoinData>(&arg0.id, v0)
    }

    public fun get_max_age_seconds(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName) : u64 {
        get_coin_data(get_pyth_oracle(arg0), arg1).max_age_seconds
    }

    public fun get_pyth_oracle(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &PythOracle {
        let v0 = PythOracleKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<Oracle, PythOracleKey, PythOracle>(arg0, v0)
    }

    fun get_pyth_oracle_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut PythOracle {
        let v0 = Oracle{dummy_field: false};
        let v1 = PythOracleKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<Oracle, PythOracleKey, PythOracle>(arg0, v0, v1)
    }

    public fun get_unsafe_usd_price_no_checks(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)
        };
        let v4 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::i64::neg_from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2))
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::i64::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2))
        };
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_scientific(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), v3, v4)
    }

    fun get_usd_price(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == get_coin_data(get_pyth_oracle(arg0), arg1).price_id, 13836466710066495497);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v5 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3)
        };
        let v6 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4)) {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::i64::neg_from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4))
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::i64::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4))
        };
        (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_scientific(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), v5, v6), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_scientific(false, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0), v6), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0))
    }

    fun has_coin_data(arg0: &PythOracle, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = CoinDataKey{coin_type: arg1};
        0x2::dynamic_object_field::exists_<CoinDataKey>(&arg0.id, v0)
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ORACLE>(arg0, arg1);
    }

    public fun manager_create_pyth_oracle_and_add_to_sweethouse(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Oracle>(arg1, 0x2::tx_context::sender(arg2));
        create_pyth_oracle_and_add_to_sweethouse_internal(arg0, arg2);
    }

    public fun manager_set_coin_data<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Oracle>(arg1, 0x2::tx_context::sender(arg4));
        set_coin_data_internal<T0>(arg0, arg2, arg3, arg4);
    }

    public fun new_key() : PythOracleKey {
        PythOracleKey{dummy_field: false}
    }

    public fun price_lower_bound(arg0: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg1: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::sub(arg0, arg1)
    }

    public fun price_upper_bound(arg0: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg1: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(arg0, arg1)
    }

    fun set_coin_data_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_pyth_oracle_mut(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = CoinDataKey{coin_type: v1};
        if (0x2::dynamic_object_field::exists_<CoinDataKey>(&v0.id, v2)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<CoinDataKey, CoinData>(&mut v0.id, v2);
            v3.price_id = arg1;
            v3.max_age_seconds = arg2;
            let v4 = OracleCoinDataUpsertedEvent{
                actor           : 0x2::tx_context::sender(arg3),
                coin_type       : v1,
                price_id        : v3.price_id,
                max_age_seconds : v3.max_age_seconds,
                was_created     : false,
            };
            0x2::event::emit<OracleCoinDataUpsertedEvent>(v4);
        } else {
            let v5 = CoinData{
                id              : 0x2::object::new(arg3),
                price_id        : arg1,
                max_age_seconds : arg2,
            };
            0x2::dynamic_object_field::add<CoinDataKey, CoinData>(&mut v0.id, v2, v5);
            let v6 = 0x2::dynamic_object_field::borrow<CoinDataKey, CoinData>(&v0.id, v2);
            let v7 = OracleCoinDataUpsertedEvent{
                actor           : 0x2::tx_context::sender(arg3),
                coin_type       : v1,
                price_id        : v6.price_id,
                max_age_seconds : v6.max_age_seconds,
                was_created     : true,
            };
            0x2::event::emit<OracleCoinDataUpsertedEvent>(v7);
        };
    }

    // decompiled from Move bytecode v6
}

