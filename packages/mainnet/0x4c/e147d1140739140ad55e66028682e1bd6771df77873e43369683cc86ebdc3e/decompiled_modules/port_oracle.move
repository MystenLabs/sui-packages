module 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::port_oracle {
    struct PortOracle has key {
        id: 0x2::object::UID,
        update_price_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        prices: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        oracle_infos: 0x2::table::Table<0x1::type_name::TypeName, OracleInfo>,
    }

    struct OracleInfo has drop, store {
        price_pyth_feed_id: 0x1::option::Option<vector<u8>>,
        price_info_object_id: 0x1::option::Option<0x2::object::ID>,
        price_aggregator_id: 0x1::option::Option<0x2::object::ID>,
        usd_price_age: u64,
        coin_decimals: u8,
    }

    struct Price has copy, drop, store {
        price: u64,
        coin_decimals: u8,
        last_update_time: u64,
    }

    struct InitEvent has copy, drop {
        pyth_oracle_id: 0x2::object::ID,
    }

    struct AddPythOracleInfoEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        price_pyth_feed_id: vector<u8>,
        price_info_object_id: 0x2::object::ID,
        usd_price_age: u64,
    }

    struct AddSwitchboardOracleInfoEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        price_aggregator_id: 0x2::object::ID,
        usd_price_age: u64,
    }

    struct RemovePythOracleInfoEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
    }

    struct UpdateOraclePriceAgeEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        old_usd_price_age: u64,
        new_usd_price_age: u64,
    }

    struct DepositFeeEvent has copy, drop {
        amount: u64,
    }

    struct UpdatePriceEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        last_update_time: u64,
    }

    public fun add_pyth_oracle_info<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x2::coin::CoinMetadata<T0>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg6));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg2, arg4);
        let v2 = if (0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0)) {
            let v3 = 0x2::table::remove<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0);
            assert!(0x1::option::is_none<0x2::object::ID>(&v3.price_aggregator_id), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::switchboard_oracle_info_already_exists());
            v3.price_pyth_feed_id = 0x1::option::some<vector<u8>>(arg4);
            v3.price_info_object_id = 0x1::option::some<0x2::object::ID>(v1);
            v3
        } else {
            OracleInfo{price_pyth_feed_id: 0x1::option::some<vector<u8>>(arg4), price_info_object_id: 0x1::option::some<0x2::object::ID>(v1), price_aggregator_id: 0x1::option::none<0x2::object::ID>(), usd_price_age: arg5, coin_decimals: 0x2::coin::get_decimals<T0>(arg3)}
        };
        0x2::table::add<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0, v2);
        let v4 = AddPythOracleInfoEvent{
            type_name            : v0,
            price_pyth_feed_id   : arg4,
            price_info_object_id : v1,
            usd_price_age        : arg5,
        };
        0x2::event::emit<AddPythOracleInfoEvent>(v4);
    }

    public fun add_switchboard_oracle_info<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_exists());
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0)) {
            let v2 = 0x2::table::remove<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0);
            assert!(0x1::option::is_none<vector<u8>>(&v2.price_pyth_feed_id), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::pyth_oracle_info_already_exists());
            v2.price_aggregator_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg3));
            v2
        } else {
            OracleInfo{price_pyth_feed_id: 0x1::option::none<vector<u8>>(), price_info_object_id: 0x1::option::none<0x2::object::ID>(), price_aggregator_id: 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg3)), usd_price_age: arg4, coin_decimals: 0x2::coin::get_decimals<T0>(arg2)}
        };
        0x2::table::add<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0, v1);
        let v3 = AddSwitchboardOracleInfoEvent{
            type_name           : v0,
            price_aggregator_id : 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg3),
            usd_price_age       : arg4,
        };
        0x2::event::emit<AddSwitchboardOracleInfoEvent>(v3);
    }

    public fun calculate_oracle_prices<T0, T1>(arg0: &PortOracle, arg1: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v1), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        let v2 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, v0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == v2.last_update_time, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_updated());
        let v3 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == v3.last_update_time, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_updated());
        let (v4, v5) = calculate_prices_from_base_quote(v2.price, v3.price, v2.coin_decimals, v3.coin_decimals);
        (v4, v5, v2.price, v3.price)
    }

    public fun calculate_prices(arg0: &Price, arg1: &Price) : (u64, u64) {
        calculate_prices_from_base_quote(arg0.price, arg1.price, arg0.coin_decimals, arg1.coin_decimals)
    }

    fun calculate_prices_from_base_quote(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : (u64, u64) {
        let v0 = if (10 + arg3 < arg2) {
            (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg0 as u128), 1, (arg1 as u128)), 1, (0x1::u64::pow(10, arg2 - 10 + arg3) as u128)) as u64)
        } else {
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg0, 0x1::u64::pow(10, 10 + arg3 - arg2), arg1)
        };
        let v1 = if (10 + arg2 < arg3) {
            (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg1 as u128), 1, (arg0 as u128)), 1, (0x1::u64::pow(10, arg3 - 10 + arg2) as u128)) as u64)
        } else {
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(arg1, 0x1::u64::pow(10, 10 + arg2 - arg3), arg0)
        };
        (v0, v1)
    }

    public fun coin_decimals(arg0: &OracleInfo) : u8 {
        arg0.coin_decimals
    }

    public fun contain_oracle_info(arg0: &PortOracle, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, arg1)
    }

    public fun deposit_fee(arg0: &mut PortOracle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.update_price_fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3)));
        let v0 = DepositFeeEvent{amount: arg2};
        0x2::event::emit<DepositFeeEvent>(v0);
    }

    public fun external_update_price_from_pyth<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v1));
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2);
        let v4 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v5 = if (v4 >= v3) {
            v4 - v3
        } else {
            0
        };
        assert!(v5 <= 0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0).usd_price_age, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_updated());
        let v6 = update_price_from_type<T0>(arg0, arg2, arg3);
        let v7 = UpdatePriceEvent{
            coin_type        : v0,
            price            : v6.price,
            last_update_time : v6.last_update_time,
        };
        0x2::event::emit<UpdatePriceEvent>(v7);
    }

    public fun external_update_price_from_switchboard<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg3: &0x2::clock::Clock) {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0);
        let v2 = Price{
            price            : switchboard_price_from_oracle_info(arg2, v1, arg3),
            coin_decimals    : v1.coin_decimals,
            last_update_time : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0, v2);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0) = v2;
        };
        let v3 = UpdatePriceEvent{
            coin_type        : v0,
            price            : v2.price,
            last_update_time : v2.last_update_time,
        };
        0x2::event::emit<UpdatePriceEvent>(v3);
    }

    public fun get_price<T0>(arg0: &PortOracle, arg1: &0x2::clock::Clock) : Price {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_exists());
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, v0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == v1.last_update_time, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_updated());
        v1
    }

    public fun get_price_aggregator_id<T0>(arg0: &PortOracle) : 0x1::option::Option<0x2::object::ID> {
        oracle_info<T0>(arg0).price_aggregator_id
    }

    public fun get_price_by_type(arg0: &PortOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : Price {
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, arg1), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_exists());
        let v0 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == v0.last_update_time, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_updated());
        v0
    }

    public fun get_price_pyth_feed_id<T0>(arg0: &PortOracle) : 0x1::option::Option<vector<u8>> {
        0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, 0x1::type_name::with_defining_ids<T0>()).price_pyth_feed_id
    }

    public fun get_sqrt_price_from_oracle<T0, T1>(arg0: &PortOracle, arg1: &0x2::clock::Clock) : u128 {
        let v0 = get_price<T0>(arg0, arg1);
        let v1 = get_price<T1>(arg0, arg1);
        let (v2, _) = calculate_prices(&v0, &v1);
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_utils::price_to_sqrt_price(v2, 10)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PortOracle{
            id               : 0x2::object::new(arg0),
            update_price_fee : 0x2::balance::zero<0x2::sui::SUI>(),
            prices           : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            oracle_infos     : 0x2::table::new<0x1::type_name::TypeName, OracleInfo>(arg0),
        };
        let v1 = InitEvent{pyth_oracle_id: 0x2::object::id<PortOracle>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<PortOracle>(v0);
    }

    public fun last_update_time(arg0: &Price) : u64 {
        arg0.last_update_time
    }

    public fun new_price(arg0: u64, arg1: u8) : Price {
        Price{
            price            : arg0,
            coin_decimals    : arg1,
            last_update_time : 0,
        }
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun oracle_info<T0>(arg0: &PortOracle) : &OracleInfo {
        0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun price_aggregator_id(arg0: &OracleInfo) : 0x1::option::Option<0x2::object::ID> {
        arg0.price_aggregator_id
    }

    public fun price_coin_decimal(arg0: &Price) : u8 {
        arg0.coin_decimals
    }

    public fun price_info_object_id(arg0: &OracleInfo) : 0x1::option::Option<0x2::object::ID> {
        arg0.price_info_object_id
    }

    public fun price_multiplier_decimal() : u8 {
        10
    }

    public fun price_pyth_feed_id(arg0: &OracleInfo) : 0x1::option::Option<vector<u8>> {
        arg0.price_pyth_feed_id
    }

    public fun price_value(arg0: &Price) : u64 {
        arg0.price
    }

    public fun pyth_price_from_oracle_info(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &OracleInfo, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg2, arg1.usd_price_age);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = if (0x1::option::is_some<vector<u8>>(&arg1.price_pyth_feed_id)) {
            let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2);
            0x1::option::borrow<vector<u8>>(&arg1.price_pyth_feed_id) == &v4
        } else {
            false
        };
        assert!(v3, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::invalid_price_feed_id());
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v7 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v6)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v6)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6)
        };
        assert!(v7 != 0, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::invalid_oracle_price());
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5)) {
            let v9 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5) as u8);
            if (v9 < 10) {
                v7 * 0x1::u64::pow(10, 10 - v9)
            } else {
                v7 / 0x1::u64::pow(10, v9 - 10)
            }
        } else {
            v7 * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u8) + 10)
        }
    }

    public fun remove_pyth_oracle_info<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1.price_aggregator_id)) {
            v1.price_pyth_feed_id = 0x1::option::none<vector<u8>>();
            v1.price_info_object_id = 0x1::option::none<0x2::object::ID>();
            0x2::table::add<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0, v1);
        };
        let v2 = RemovePythOracleInfoEvent{type_name: v0};
        0x2::event::emit<RemovePythOracleInfoEvent>(v2);
    }

    public fun remove_switchboard_oracle_info<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0);
        if (0x1::option::is_some<vector<u8>>(&v1.price_pyth_feed_id)) {
            v1.price_aggregator_id = 0x1::option::none<0x2::object::ID>();
            0x2::table::add<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0, v1);
        };
        let v2 = RemovePythOracleInfoEvent{type_name: v0};
        0x2::event::emit<RemovePythOracleInfoEvent>(v2);
    }

    public(friend) fun split_fee(arg0: &mut PortOracle, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.update_price_fee) >= arg1, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::update_price_fee_not_enough());
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.update_price_fee, arg1)
    }

    public fun switchboard_price_from_oracle_info(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &OracleInfo, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (0x1::option::is_some<0x2::object::ID>(&arg1.price_aggregator_id)) {
            let v1 = 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg0);
            0x1::option::borrow<0x2::object::ID>(&arg1.price_aggregator_id) == &v1
        } else {
            false
        };
        assert!(v0, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::switchboard_aggregator_not_match());
        let v2 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg0);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_timestamp_ms(v2) + arg1.usd_price_age * 1000 > 0x2::clock::timestamp_ms(arg2), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_not_updated());
        let v3 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v2);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v3), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::invalid_aggregator_price());
        let v4 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v3);
        let v5 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::dec(v3);
        assert!(v4 != 0, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::invalid_oracle_price());
        let v6 = if (v5 < 10) {
            v4 * (0x1::u64::pow(10, 10 - v5) as u128)
        } else {
            v4 / (0x1::u64::pow(10, v5 - 10) as u128)
        };
        (v6 as u64)
    }

    public fun update_price<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg4: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0)) {
            let v1 = update_price_from_type<T0>(arg0, arg4, arg5);
            let v2 = UpdatePriceEvent{
                coin_type        : v0,
                price            : v1.price,
                last_update_time : v1.last_update_time,
            };
            0x2::event::emit<UpdatePriceEvent>(v2);
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, arg3, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(split_fee(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg2)), arg6), arg5)
    }

    public fun update_price_age<T0>(arg0: &mut PortOracle, arg1: &0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::checked_package_version(arg1);
        0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::vault_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0);
        let v2 = UpdateOraclePriceAgeEvent{
            type_name         : v0,
            old_usd_price_age : v1.usd_price_age,
            new_usd_price_age : arg2,
        };
        0x2::event::emit<UpdateOraclePriceAgeEvent>(v2);
        v1.usd_price_age = arg2;
    }

    fun update_price_from_type<T0>(arg0: &mut PortOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : Price {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::oracle_info_not_exists());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0);
        let v2 = if (0x1::option::is_some<0x2::object::ID>(&v1.price_info_object_id)) {
            let v3 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
            0x1::option::borrow<0x2::object::ID>(&v1.price_info_object_id) == &v3
        } else {
            false
        };
        assert!(v2, 0x4ce147d1140739140ad55e66028682e1bd6771df77873e43369683cc86ebdc3e::error::price_object_not_match_with_coin_type());
        let v4 = Price{
            price            : pyth_price_from_oracle_info(arg1, v1, arg2),
            coin_decimals    : v1.coin_decimals,
            last_update_time : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0, v4);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0) = v4;
        };
        v4
    }

    public fun usd_price_age(arg0: &OracleInfo) : u64 {
        arg0.usd_price_age
    }

    // decompiled from Move bytecode v6
}

