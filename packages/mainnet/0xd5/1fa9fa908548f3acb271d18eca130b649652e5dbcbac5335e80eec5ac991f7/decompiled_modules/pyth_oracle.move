module 0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::pyth_oracle {
    struct PythOracle has key {
        id: 0x2::object::UID,
        update_price_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        prices: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        oracle_infos: 0x2::table::Table<0x1::type_name::TypeName, OracleInfo>,
    }

    struct OracleInfo has drop, store {
        price_feed_id: vector<u8>,
        price_info_object_id: 0x2::object::ID,
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

    struct AddOracleInfoEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        price_feed_id: vector<u8>,
        price_info_object_id: 0x2::object::ID,
        usd_price_age: u64,
    }

    struct RemoveOracleInfoEvent has copy, drop {
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

    public fun get_price<T0>(arg0: &PythOracle, arg1: &0x2::clock::Clock) : Price {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0), 13837031678655135762);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, v0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == v1.last_update_time, 13837313170811846676);
        v1
    }

    public fun add_oracle_info<T0>(arg0: &mut PythOracle, arg1: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x2::coin::CoinMetadata<T0>, arg4: vector<u8>, arg5: u64, arg6: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::Versioned, arg7: &0x2::tx_context::TxContext) {
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::check_version(arg6);
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg7));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835622267956428808);
        assert!(arg5 > 0 && arg5 <= 600, 13837592597089288214);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg2, arg4);
        let v2 = OracleInfo{
            price_feed_id        : arg4,
            price_info_object_id : v1,
            usd_price_age        : arg5,
            coin_decimals        : 0x2::coin::get_decimals<T0>(arg3),
        };
        0x2::table::add<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0, v2);
        let v3 = AddOracleInfoEvent{
            type_name            : v0,
            price_feed_id        : arg4,
            price_info_object_id : v1,
            usd_price_age        : arg5,
        };
        0x2::event::emit<AddOracleInfoEvent>(v3);
    }

    public fun add_oracle_info_v2<T0>(arg0: &mut PythOracle, arg1: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x2::coin_registry::Currency<T0>, arg4: vector<u8>, arg5: u64, arg6: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::Versioned, arg7: &0x2::tx_context::TxContext) {
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::check_version(arg6);
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg7));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835622486999760904);
        assert!(arg5 > 0 && arg5 <= 600, 13837592816132620310);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg2, arg4);
        let v2 = OracleInfo{
            price_feed_id        : arg4,
            price_info_object_id : v1,
            usd_price_age        : arg5,
            coin_decimals        : 0x2::coin_registry::decimals<T0>(arg3),
        };
        0x2::table::add<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0, v2);
        let v3 = AddOracleInfoEvent{
            type_name            : v0,
            price_feed_id        : arg4,
            price_info_object_id : v1,
            usd_price_age        : arg5,
        };
        0x2::event::emit<AddOracleInfoEvent>(v3);
    }

    public fun calculate_oracle_prices<T0, T1>(arg0: &PythOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835904507437449226);
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v1), 13835904511732416522);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0);
        let v3 = 0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v1);
        assert!(v2.price_info_object_id == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), 13836186008184094732);
        assert!(v3.price_info_object_id == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2), 13836186025363963916);
        let v4 = pyth_price_from_oracle_info(arg1, v2, arg3);
        let v5 = pyth_price_from_oracle_info(arg2, v3, arg3);
        let (v6, v7) = calculate_prices_from_base_quote(v4, v5, v2.coin_decimals, v3.coin_decimals);
        (v6, v7, v4, v5)
    }

    public fun calculate_prices(arg0: &Price, arg1: &Price) : (u64, u64) {
        calculate_prices_from_base_quote(arg0.price, arg1.price, arg0.coin_decimals, arg1.coin_decimals)
    }

    fun calculate_prices_from_base_quote(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : (u64, u64) {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(arg0, 0x1::u64::pow(10, 10 + arg3 - arg2), arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(arg1, 0x1::u64::pow(10, 10 + arg2 - arg3), arg0))
    }

    fun calculate_prices_from_base_quote_v2(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : (u128, u128) {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), 0x1::u128::pow(10, 18 + arg3 - arg2), (arg1 as u128)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg1 as u128), 0x1::u128::pow(10, 18 + arg2 - arg3), (arg0 as u128)))
    }

    public fun calculate_prices_v2(arg0: &Price, arg1: &Price) : (u128, u128) {
        calculate_prices_from_base_quote_v2(arg0.price, arg1.price, arg0.coin_decimals, arg1.coin_decimals)
    }

    public fun coin_decimals(arg0: &OracleInfo) : u8 {
        arg0.coin_decimals
    }

    public fun contain_oracle_info(arg0: &PythOracle, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, arg1)
    }

    public fun deposit_fee(arg0: &mut PythOracle, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::Versioned) {
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::check_version(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.update_price_fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = DepositFeeEvent{amount: 0x2::coin::value<0x2::sui::SUI>(&arg1)};
        0x2::event::emit<DepositFeeEvent>(v0);
    }

    public fun get_price_by_type(arg0: &PythOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : Price {
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, arg1), 13837031781734350866);
        let v0 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == v0.last_update_time, 13837313273891061780);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythOracle{
            id               : 0x2::object::new(arg0),
            update_price_fee : 0x2::balance::zero<0x2::sui::SUI>(),
            prices           : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            oracle_infos     : 0x2::table::new<0x1::type_name::TypeName, OracleInfo>(arg0),
        };
        let v1 = InitEvent{pyth_oracle_id: 0x2::object::id<PythOracle>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<PythOracle>(v0);
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

    public fun oracle_info<T0>(arg0: &PythOracle) : &OracleInfo {
        0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun price_coin_decimal(arg0: &Price) : u8 {
        arg0.coin_decimals
    }

    public fun price_feed_id(arg0: &OracleInfo) : vector<u8> {
        arg0.price_feed_id
    }

    public fun price_info_object_id(arg0: &OracleInfo) : 0x2::object::ID {
        arg0.price_info_object_id
    }

    public fun price_value(arg0: &Price) : u64 {
        arg0.price
    }

    public fun pyth_price_from_oracle_info(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &OracleInfo, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg2, arg1.usd_price_age);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(arg1.price_feed_id == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), 13836468389399035918);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), 13835061035989663748);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4);
        assert!(v5 != 0, 13836749894440648720);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_round(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0), 10000, v5) <= 500, 13837875811527884824);
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

    public fun remove_oracle_info<T0>(arg0: &mut PythOracle, arg1: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::GlobalConfig, arg2: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::check_version(arg2);
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835904146660196362);
        0x2::table::remove<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0);
        if (0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0);
        };
        let v1 = RemoveOracleInfoEvent{type_name: v0};
        0x2::event::emit<RemoveOracleInfoEvent>(v1);
    }

    public(friend) fun split_fee(arg0: &mut PythOracle, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.update_price_fee) >= arg1, 13835340569641287686);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.update_price_fee, arg1)
    }

    public fun update_price<T0>(arg0: &mut PythOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::check_version(arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835904825265029130);
        let v1 = split_fee(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg1));
        let v2 = update_price_from_type<T0>(arg0, arg3, arg4);
        let v3 = UpdatePriceEvent{
            coin_type        : v0,
            price            : v2.price,
            last_update_time : v2.last_update_time,
        };
        0x2::event::emit<UpdatePriceEvent>(v3);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg6), arg4)
    }

    public fun update_price_age<T0>(arg0: &mut PythOracle, arg1: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::GlobalConfig, arg2: u64, arg3: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::check_version(arg3);
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835904318458888202);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, OracleInfo>(&mut arg0.oracle_infos, v0);
        assert!(v1.usd_price_age != arg2, 13837593181204840470);
        assert!(arg2 > 0 && arg2 <= 600, 13837593185499807766);
        let v2 = UpdateOraclePriceAgeEvent{
            type_name         : v0,
            old_usd_price_age : v1.usd_price_age,
            new_usd_price_age : arg2,
        };
        0x2::event::emit<UpdateOraclePriceAgeEvent>(v2);
        v1.usd_price_age = arg2;
    }

    fun update_price_from_type<T0>(arg0: &mut PythOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : Price {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835905173157380106);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0);
        assert!(v1.price_info_object_id == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), 13836186665314091020);
        let v2 = Price{
            price            : pyth_price_from_oracle_info(arg1, v1, arg2),
            coin_decimals    : v1.coin_decimals,
            last_update_time : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0, v2);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0) = v2;
        };
        v2
    }

    public fun update_price_into_pyth_oracle<T0>(arg0: &mut PythOracle, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: &0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::versioned::check_version(arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, OracleInfo>(&arg0.oracle_infos, v0), 13835905014243590154);
        let v1 = update_price_from_type<T0>(arg0, arg1, arg2);
        let v2 = UpdatePriceEvent{
            coin_type        : v0,
            price            : v1.price,
            last_update_time : v1.last_update_time,
        };
        0x2::event::emit<UpdatePriceEvent>(v2);
    }

    public fun usd_price_age(arg0: &OracleInfo) : u64 {
        arg0.usd_price_age
    }

    // decompiled from Move bytecode v6
}

