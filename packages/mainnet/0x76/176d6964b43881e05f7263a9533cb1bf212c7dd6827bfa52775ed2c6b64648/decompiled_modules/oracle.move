module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle {
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

    struct PriceQuote has copy, drop {
        price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        conf: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        publish_time_unix_seconds: u64,
        price_id: vector<u8>,
    }

    public fun GET_CPYTH_PRICE() : u64 {
        1024
    }

    public fun GET_CZERO_VALUE() : u64 {
        1
    }

    fun adjust_price_or_zero(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg4: u64, arg5: &0x2::clock::Clock) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        if (arg4 > v0) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        if (v0 - arg4 >= get_max_age_seconds(arg0, arg1)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_negative(&arg2)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        let v1 = price_lower_bound(arg2, arg3);
        if (!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive(&v1)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        v1
    }

    public fun adjust_quoted_price_or_zero(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: PriceQuote, arg3: &0x2::clock::Clock) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        if (!has_coin_data(get_pyth_oracle(arg0), arg1)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        let (v0, v1, v2) = usd_price_from_quote(arg0, arg1, arg2);
        adjust_price_or_zero(arg0, arg1, v0, v1, v2, arg3)
    }

    public fun admin_create_pyth_oracle_and_add_to_sweethouse(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_pyth_oracle_and_add_to_sweethouse_internal(arg0, arg2);
    }

    public fun admin_set_coin_data<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        set_coin_data_internal<T0>(arg0, arg2, arg3, arg4);
    }

    public fun check_quoted_usd_price(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: PriceQuote, arg3: &0x2::clock::Clock) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, u64) {
        let (v0, v1, v2) = usd_price_from_quote(arg0, arg1, arg2);
        check_usd_price(arg0, arg1, v0, v1, v2, arg3)
    }

    fun check_usd_price(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg4: u64, arg5: &0x2::clock::Clock) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(arg4 <= v0, 13835341527418798083);
        assert!(v0 - arg4 < get_max_age_seconds(arg0, arg1), 13835341540303699971);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_negative(&arg2), 13835341544598667267);
        let v1 = price_lower_bound(arg2, arg3);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive(&v1), 13835623032460410885);
        (arg2, arg3, arg4)
    }

    fun create_pyth_oracle_and_add_to_sweethouse_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PythOracle{id: 0x2::object::new(arg1)};
        let v1 = Oracle{dummy_field: false};
        let v2 = PythOracleKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Oracle, PythOracleKey, PythOracle>(arg0, v1, v2, v0);
        let v3 = PythOracleCreatedEvent{
            actor     : 0x2::tx_context::sender(arg1),
            oracle_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<PythOracleCreatedEvent>(v3);
    }

    fun decode_price_parts(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) {
        let v0 = if (arg3) {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::neg_from(arg4)
        } else {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(arg4)
        };
        (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_scientific(arg0, arg1, v0), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_scientific(false, arg2, v0))
    }

    public fun get_adjusted_price_or_zero(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        if (!has_coin_data(get_pyth_oracle(arg0), arg1)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        let (v0, v1, v2) = usd_price_from_quote(arg0, arg1, read_price_quote(arg2));
        adjust_price_or_zero(arg0, arg1, v0, v1, v2, arg3)
    }

    public fun get_adjusted_price_or_zero_v2(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        if (!has_coin_data(get_pyth_oracle(arg0), arg1)) {
            return 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
        };
        let (v0, v1, v2) = usd_price_from_quote(arg0, arg1, read_price_quote_v2(arg2));
        adjust_price_or_zero(arg0, arg1, v0, v1, v2, arg3)
    }

    public fun get_checked_usd_price(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, u64) {
        check_quoted_usd_price(arg0, arg1, read_price_quote(arg2), arg3)
    }

    public fun get_checked_usd_price_v2(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, u64) {
        check_quoted_usd_price(arg0, arg1, read_price_quote_v2(arg2), arg3)
    }

    fun get_coin_data(arg0: &PythOracle, arg1: 0x1::type_name::TypeName) : &CoinData {
        let v0 = CoinDataKey{coin_type: arg1};
        assert!(0x2::dynamic_object_field::exists_<CoinDataKey>(&arg0.id, v0), 13836184526420181001);
        0x2::dynamic_object_field::borrow<CoinDataKey, CoinData>(&arg0.id, v0)
    }

    public fun get_max_age_seconds(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName) : u64 {
        get_coin_data(get_pyth_oracle(arg0), arg1).max_age_seconds
    }

    public fun get_pyth_oracle(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &PythOracle {
        let v0 = PythOracleKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Oracle, PythOracleKey, PythOracle>(arg0, v0)
    }

    fun get_pyth_oracle_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut PythOracle {
        let v0 = Oracle{dummy_field: false};
        let v1 = PythOracleKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Oracle, PythOracleKey, PythOracle>(arg0, v0, v1)
    }

    public fun get_unsafe_usd_price_no_checks(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = read_price_quote(arg0);
        v0.price
    }

    public fun get_unsafe_usd_price_no_checks_v2(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = read_price_quote_v2(arg0);
        v0.price
    }

    fun has_coin_data(arg0: &PythOracle, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = CoinDataKey{coin_type: arg1};
        0x2::dynamic_object_field::exists_<CoinDataKey>(&arg0.id, v0)
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ORACLE>(arg0, arg1);
    }

    public fun manager_create_pyth_oracle_and_add_to_sweethouse(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Oracle>(arg1, 0x2::tx_context::sender(arg2));
        create_pyth_oracle_and_add_to_sweethouse_internal(arg0, arg2);
    }

    public fun manager_set_coin_data<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Oracle>(arg1, 0x2::tx_context::sender(arg4));
        set_coin_data_internal<T0>(arg0, arg2, arg3, arg4);
    }

    public fun new_key() : PythOracleKey {
        PythOracleKey{dummy_field: false}
    }

    public fun price_lower_bound(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::sub(arg0, arg1)
    }

    public fun price_upper_bound(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(arg0, arg1)
    }

    public fun quote_unsafe_price(arg0: &PriceQuote) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        arg0.price
    }

    public fun read_price_quote(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : PriceQuote {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v5 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3)
        };
        let v6 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4)
        };
        let (v7, v8) = decode_price_parts(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), v5, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), v6);
        PriceQuote{
            price                     : v7,
            conf                      : v8,
            publish_time_unix_seconds : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0),
            price_id                  : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2),
        }
    }

    public fun read_price_quote_v2(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : PriceQuote {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v1);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v0);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v0);
        let v5 = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3)) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v3)
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v3)
        };
        let v6 = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v4)) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v4)
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v4)
        };
        let (v7, v8) = decode_price_parts(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3), v5, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v0), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v4), v6);
        PriceQuote{
            price                     : v7,
            conf                      : v8,
            publish_time_unix_seconds : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0),
            price_id                  : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2),
        }
    }

    fun set_coin_data_internal<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13835903339206148103);
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

    fun usd_price_from_quote(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: 0x1::type_name::TypeName, arg2: PriceQuote) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, u64) {
        assert!(arg2.price_id == get_coin_data(get_pyth_oracle(arg0), arg1).price_id, 13836467139563356171);
        (arg2.price, arg2.conf, arg2.publish_time_unix_seconds)
    }

    // decompiled from Move bytecode v7
}

