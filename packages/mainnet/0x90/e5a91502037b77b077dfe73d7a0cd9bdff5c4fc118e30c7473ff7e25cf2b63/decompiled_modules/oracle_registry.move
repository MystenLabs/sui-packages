module 0x90e5a91502037b77b077dfe73d7a0cd9bdff5c4fc118e30c7473ff7e25cf2b63::oracle_registry {
    struct OracleRegistry has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        coin_infos: 0x2::table::Table<0x1::type_name::TypeName, CoinInfo>,
    }

    struct CoinInfo has drop, store {
        price_feed_id: vector<u8>,
        price_info_object_id: 0x2::object::ID,
        max_age: u64,
        decimal: u8,
        slippage: u64,
    }

    struct Price has copy, drop, store {
        price: u64,
        decimal: u8,
        last_update_time: u64,
    }

    struct InitEvent has copy, drop {
        oracle_registry_id: 0x2::object::ID,
    }

    struct AddCoinInfoEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        price_feed_id: vector<u8>,
        price_info_object_id: 0x2::object::ID,
        max_age: u64,
    }

    struct RemoveCoinInfoEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
    }

    struct UpdateCoinMaxAgeEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        old_max_age: u64,
        new_max_age: u64,
    }

    struct UpdateCoinSlippageEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        old_slippage: u64,
        new_slippage: u64,
    }

    struct UpdatePriceEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        last_update_time: u64,
    }

    public fun get_price<T0>(arg0: &OracleRegistry, arg1: &0x2::clock::Clock) : Price {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0), 8);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, v0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == v1.last_update_time, 9);
        v1
    }

    public(friend) fun add_coin_info<T0>(arg0: &mut OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x2::coin::CoinMetadata<T0>, arg3: vector<u8>, arg4: u64, arg5: u64) {
        add_coin_info_internal<T0>(arg0, arg1, arg3, arg4, arg5, 0x2::coin::get_decimals<T0>(arg2));
    }

    fun add_coin_info_internal<T0>(arg0: &mut OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0), 3);
        assert!(arg3 > 0 && arg3 <= 600, 10);
        assert!(arg4 > 0 && arg4 <= 10000, 10);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg1, arg2);
        let v2 = CoinInfo{
            price_feed_id        : arg2,
            price_info_object_id : v1,
            max_age              : arg3,
            decimal              : arg5,
            slippage             : arg4,
        };
        0x2::table::add<0x1::type_name::TypeName, CoinInfo>(&mut arg0.coin_infos, v0, v2);
        let v3 = AddCoinInfoEvent{
            type_name            : v0,
            price_feed_id        : arg2,
            price_info_object_id : v1,
            max_age              : arg3,
        };
        0x2::event::emit<AddCoinInfoEvent>(v3);
    }

    public(friend) fun add_coin_info_use_currency<T0>(arg0: &mut OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x2::coin_registry::Currency<T0>, arg3: vector<u8>, arg4: u64, arg5: u64) {
        add_coin_info_internal<T0>(arg0, arg1, arg3, arg4, arg5, 0x2::coin_registry::decimals<T0>(arg2));
    }

    public fun calculate_prices(arg0: &Price, arg1: &Price) : (u128, u128) {
        calculate_prices_from_base_quote(arg0.price, arg1.price, arg0.decimal, arg1.decimal)
    }

    fun calculate_prices_from_base_quote(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : (u128, u128) {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), 0x1::u128::pow(10, 20 + arg3 - arg2), (arg1 as u128)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg1 as u128), 0x1::u128::pow(10, 20 + arg2 - arg3), (arg0 as u128)))
    }

    public fun coin_info<T0>(arg0: &OracleRegistry) : &CoinInfo {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0), 4);
        0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0)
    }

    public fun contain_coin_info(arg0: &OracleRegistry, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, arg1)
    }

    public fun decimal(arg0: &CoinInfo) : u8 {
        arg0.decimal
    }

    public fun get_price_by_type(arg0: &OracleRegistry, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : Price {
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, arg1), 8);
        let v0 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == v0.last_update_time, 9);
        v0
    }

    public(friend) fun init_oracle_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id         : 0x2::object::new(arg0),
            prices     : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            coin_infos : 0x2::table::new<0x1::type_name::TypeName, CoinInfo>(arg0),
        };
        let v1 = InitEvent{oracle_registry_id: 0x2::object::id<OracleRegistry>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<OracleRegistry>(v0);
    }

    public fun last_update_time(arg0: &Price) : u64 {
        arg0.last_update_time
    }

    public fun max_age(arg0: &CoinInfo) : u64 {
        arg0.max_age
    }

    public fun price_decimal(arg0: &Price) : u8 {
        arg0.decimal
    }

    public fun price_feed_id(arg0: &CoinInfo) : vector<u8> {
        arg0.price_feed_id
    }

    public fun price_info_object_id(arg0: &CoinInfo) : 0x2::object::ID {
        arg0.price_info_object_id
    }

    public fun price_value(arg0: &Price) : u64 {
        arg0.price
    }

    fun pyth_price_from_coin_info(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &CoinInfo, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg2, arg1.max_age);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(arg1.price_feed_id == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), 6);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), 1);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4);
        assert!(v5 != 0, 7);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_round(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0), 10000, v5) <= 500, 11);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            let v7 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8);
            if (v7 < 10) {
                v5 * 0x1::u64::pow(10, 10 - v7)
            } else {
                v5 / 0x1::u64::pow(10, v7 - 10)
            }
        } else {
            v5 * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u8) + 10)
        }
    }

    public(friend) fun remove_coin_info<T0>(arg0: &mut OracleRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0), 4);
        0x2::table::remove<0x1::type_name::TypeName, CoinInfo>(&mut arg0.coin_infos, v0);
        if (0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0);
        };
        let v1 = RemoveCoinInfoEvent{type_name: v0};
        0x2::event::emit<RemoveCoinInfoEvent>(v1);
    }

    public fun slippage(arg0: &CoinInfo) : u64 {
        arg0.slippage
    }

    public(friend) fun update_coin_slippage<T0>(arg0: &mut OracleRegistry, arg1: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, CoinInfo>(&mut arg0.coin_infos, v0);
        assert!(v1.slippage != arg1, 10);
        assert!(arg1 > 0 && arg1 <= 10000, 10);
        let v2 = UpdateCoinSlippageEvent{
            type_name    : v0,
            old_slippage : v1.slippage,
            new_slippage : arg1,
        };
        0x2::event::emit<UpdateCoinSlippageEvent>(v2);
        v1.slippage = arg1;
    }

    public(friend) fun update_price<T0>(arg0: &mut OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0), 4);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0);
        assert!(v1.price_info_object_id == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), 5);
        let v2 = Price{
            price            : pyth_price_from_coin_info(arg1, v1, arg2),
            decimal          : v1.decimal,
            last_update_time : 0x2::clock::timestamp_ms(arg2) / 1000,
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

    public(friend) fun update_price_age<T0>(arg0: &mut OracleRegistry, arg1: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_infos, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, CoinInfo>(&mut arg0.coin_infos, v0);
        assert!(v1.max_age != arg1, 10);
        assert!(arg1 > 0 && arg1 <= 600, 10);
        let v2 = UpdateCoinMaxAgeEvent{
            type_name   : v0,
            old_max_age : v1.max_age,
            new_max_age : arg1,
        };
        0x2::event::emit<UpdateCoinMaxAgeEvent>(v2);
        v1.max_age = arg1;
    }

    // decompiled from Move bytecode v6
}

