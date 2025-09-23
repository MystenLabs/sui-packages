module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_manager {
    struct MarginManager<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        deepbook_pool: 0x2::object::ID,
        margin_pool_id: 0x1::option::Option<0x2::object::ID>,
        balance_manager: 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::BalanceManager,
        deposit_cap: 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::DepositCap,
        withdraw_cap: 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::WithdrawCap,
        trade_cap: 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::TradeCap,
        borrowed_base_shares: u64,
        borrowed_quote_shares: u64,
    }

    struct ManagerInitializer {
        margin_manager_id: 0x2::object::ID,
    }

    struct MarginManagerEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct LoanBorrowedEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        loan_amount: u64,
        total_borrow: u64,
        total_shares: u64,
        timestamp: u64,
    }

    struct LoanRepaidEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        repay_amount: u64,
        repay_shares: u64,
        timestamp: u64,
    }

    struct LiquidationEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        liquidation_amount: u64,
        pool_reward: u64,
        pool_default: u64,
        risk_ratio: u64,
        timestamp: u64,
    }

    public(friend) fun id<T0, T1>(arg0: &MarginManager<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new<T0, T1>(arg0: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MarginManager<T0, T1>>(new_margin_manager<T0, T1>(arg0, arg1, arg2, arg3));
    }

    public fun balance_manager<T0, T1>(arg0: &MarginManager<T0, T1>) : &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::BalanceManager {
        &arg0.balance_manager
    }

    public fun set_referral<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::DeepBookReferral, arg2: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg2);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::set_referral(&mut arg0.balance_manager, arg1, &arg0.trade_cap);
    }

    public fun unset_referral<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        validate_owner<T0, T1>(arg0, arg1);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::unset_referral(&mut arg0.balance_manager, &arg0.trade_cap);
    }

    public(friend) fun assert_place_reduce_only<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T2>, arg2: bool) {
        if (arg0.borrowed_base_shares == 0 && arg0.borrowed_quote_shares == 0) {
            return
        };
        if (0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>()) {
            assert!(arg2, 12);
        } else {
            assert!(!arg2, 12);
        };
    }

    fun assets_in_debt_unit<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = calculate_assets<T0, T1>(arg0, arg2);
        if (0x1::option::is_none<0x2::object::ID>(&arg0.margin_pool_id)) {
            return (0, v0, v1)
        };
        let v2 = if (arg0.borrowed_base_shares > 0) {
            0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::oracle::calculate_target_currency<T1, T0>(arg1, arg4, arg3, v1, arg5) + v0
        } else {
            0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::oracle::calculate_target_currency<T0, T1>(arg1, arg3, arg4, v0, arg5) + v1
        };
        (v2, v0, v1)
    }

    public(friend) fun balance_manager_trading_mut<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) : &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::BalanceManager {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        &mut arg0.balance_manager
    }

    public fun borrow_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg8);
        assert!(can_borrow<T0, T1, T0>(arg0, arg2), 4);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::deepbook_pool_allowed<T0>(arg2, arg0.deepbook_pool), 6);
        let (v0, v1, v2) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::borrow<T0>(arg2, arg6, arg7, arg8);
        arg0.borrowed_base_shares = v2;
        arg0.margin_pool_id = 0x1::option::some<0x2::object::ID>(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T0>(arg2));
        deposit<T0, T1, T0>(arg0, arg1, v0, arg8);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::can_borrow(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5), risk_ratio_int<T0, T1, T0>(arg0, arg1, arg3, arg4, arg5, arg2, arg7)), 7);
        let v3 = LoanBorrowedEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T0>(arg2),
            loan_amount       : arg6,
            total_borrow      : v1,
            total_shares      : v2,
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<LoanBorrowedEvent>(v3);
    }

    public fun borrow_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg8);
        assert!(can_borrow<T0, T1, T1>(arg0, arg2), 4);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::deepbook_pool_allowed<T1>(arg2, arg0.deepbook_pool), 6);
        let (v0, v1, v2) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::borrow<T1>(arg2, arg6, arg7, arg8);
        arg0.borrowed_quote_shares = v2;
        arg0.margin_pool_id = 0x1::option::some<0x2::object::ID>(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T1>(arg2));
        deposit<T0, T1, T1>(arg0, arg1, v0, arg8);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::can_borrow(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5), risk_ratio_int<T0, T1, T1>(arg0, arg1, arg3, arg4, arg5, arg2, arg7)), 7);
        let v3 = LoanBorrowedEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T1>(arg2),
            loan_amount       : arg6,
            total_borrow      : v1,
            total_shares      : v2,
            timestamp         : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<LoanBorrowedEvent>(v3);
    }

    public fun borrowed_base_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        arg0.borrowed_base_shares
    }

    public fun borrowed_quote_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : u64 {
        arg0.borrowed_quote_shares
    }

    public fun borrowed_shares<T0, T1>(arg0: &MarginManager<T0, T1>) : (u64, u64) {
        (arg0.borrowed_base_shares, arg0.borrowed_quote_shares)
    }

    public fun calculate_assets<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = balance_manager<T0, T1>(arg0);
        let (v1, v2, _) = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::locked_balance<T0, T1>(arg1, v0);
        (v1 + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::balance<T0>(v0), v2 + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::balance<T1>(v0))
    }

    fun can_borrow<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T2>) : bool {
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T2>(arg1);
        0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0) || 0x1::option::is_none<0x2::object::ID>(&arg0.margin_pool_id)
    }

    public fun deepbook_pool<T0, T1>(arg0: &MarginManager<T0, T1>) : 0x2::object::ID {
        arg0.deepbook_pool
    }

    public fun deposit<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = if (v0 == 0x1::type_name::with_defining_ids<T0>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<T1>()) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()
        };
        assert!(v1, 1);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::deposit_with_cap<T2>(&mut arg0.balance_manager, &arg0.deposit_cap, arg2, arg3);
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T2>, arg5: &mut 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(arg0.deepbook_pool == 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5), 5);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T2>(arg4);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 10);
        let v1 = risk_ratio_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, arg4, arg7);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::can_liquidate(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5), v1), 9);
        let v2 = trade_proof<T0, T1>(arg0, arg8);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::cancel_all_orders<T0, T1>(arg5, &mut arg0.balance_manager, &v2, arg7, arg8);
        let v3 = 0x1::u64::max(arg0.borrowed_base_shares, arg0.borrowed_quote_shares);
        let v4 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::borrow_shares_to_amount<T2>(arg4, v3, arg7);
        let v5 = 0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>();
        let (v6, v7, v8) = assets_in_debt_unit<T0, T1>(arg0, arg1, arg5, arg2, arg3, arg7);
        let v9 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling() + 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::user_liquidation_reward(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5)) + 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_liquidation_reward(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5));
        let v10 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::target_liquidation_risk_ratio(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5));
        let v11 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(0x1::u64::min(0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(0x1::u64::min(0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v10, v4) - v6, v10 - v9), v4), v9), v6), v9);
        let v12 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling() + 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_liquidation_reward(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg5));
        let v13 = 0x1::u64::min(v11, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(0x2::coin::value<T2>(&arg6), v12));
        let v14 = if (v1 < 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling() && v13 == v11) {
            v3
        } else {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v3, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(v13, v4))
        };
        let (v15, v16, v17) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::repay_liquidation<T2>(arg4, v14, 0x2::coin::split<T2>(&mut arg6, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v13, v12), arg8), arg7);
        if (v5) {
            arg0.borrowed_base_shares = arg0.borrowed_base_shares - v14;
        } else {
            arg0.borrowed_quote_shares = arg0.borrowed_quote_shares - v14;
        };
        let v18 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v13, v9);
        let (v19, v20) = if (v5) {
            let v21 = 0x1::u64::min(v18, v7);
            let v22 = liquidation_withdraw<T0, T1, T0>(arg0, v21, arg8);
            let v20 = liquidation_withdraw<T0, T1, T1>(arg0, 0x1::u64::min(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::oracle::calculate_target_currency<T0, T1>(arg1, arg2, arg3, v18 - v21, arg7), v8), arg8);
            (v22, v20)
        } else {
            let v23 = 0x1::u64::min(v18, v8);
            let v24 = liquidation_withdraw<T0, T1, T0>(arg0, 0x1::u64::min(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::oracle::calculate_target_currency<T1, T0>(arg1, arg3, arg2, v18 - v23, arg7), v7), arg8);
            let v20 = liquidation_withdraw<T0, T1, T1>(arg0, v23, arg8);
            (v24, v20)
        };
        let v25 = LiquidationEvent{
            margin_manager_id  : id<T0, T1>(arg0),
            margin_pool_id     : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T2>(arg4),
            liquidation_amount : v15,
            pool_reward        : v16,
            pool_default       : v17,
            risk_ratio         : v1,
            timestamp          : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<LiquidationEvent>(v25);
        (v19, v20, arg6)
    }

    fun liquidation_withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    fun new_margin_manager<T0, T1>(arg0: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : MarginManager<T0, T1> {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_enabled<T0, T1>(arg1, arg0), 2);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let (v2, v3, v4, v5) = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::new_with_custom_owner_and_caps(0x2::object::uid_to_address(&v0), arg3);
        let v6 = v2;
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::add_margin_manager(arg1, 0x2::object::uid_to_inner(&v0), arg3);
        let v7 = MarginManagerEvent{
            margin_manager_id  : 0x2::object::uid_to_inner(&v0),
            balance_manager_id : 0x2::object::id<0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::BalanceManager>(&v6),
            owner              : v1,
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarginManagerEvent>(v7);
        MarginManager<T0, T1>{
            id                    : v0,
            owner                 : v1,
            deepbook_pool         : 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg0),
            margin_pool_id        : 0x1::option::none<0x2::object::ID>(),
            balance_manager       : v6,
            deposit_cap           : v3,
            withdraw_cap          : v4,
            trade_cap             : v5,
            borrowed_base_shares  : 0,
            borrowed_quote_shares : 0,
        }
    }

    public fun new_with_initializer<T0, T1>(arg0: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (MarginManager<T0, T1>, ManagerInitializer) {
        let v0 = new_margin_manager<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = ManagerInitializer{margin_manager_id: id<T0, T1>(&v0)};
        (v0, v1)
    }

    fun repay<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T2>, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::u64::max(arg0.borrowed_base_shares, arg0.borrowed_quote_shares);
        let v1 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::borrow_shares_to_amount<T2>(arg1, v0, arg3);
        let v2 = 0x1::u64::min(0x1::option::destroy_with_default<u64>(arg2, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::balance<T2>(balance_manager<T0, T1>(arg0))), v1);
        let v3 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v0, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(v2, v1));
        let v4 = repay_withdraw<T0, T1, T2>(arg0, v2, arg4);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::repay<T2>(arg1, v3, v4, arg3);
        if (0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<T0>()) {
            arg0.borrowed_base_shares = arg0.borrowed_base_shares - v3;
        } else {
            arg0.borrowed_quote_shares = arg0.borrowed_quote_shares - v3;
        };
        if (arg0.borrowed_base_shares == 0 && arg0.borrowed_quote_shares == 0) {
            arg0.margin_pool_id = 0x1::option::none<0x2::object::ID>();
        };
        let v5 = LoanRepaidEvent{
            margin_manager_id : id<T0, T1>(arg0),
            margin_pool_id    : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T2>(arg1),
            repay_amount      : v2,
            repay_shares      : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LoanRepaidEvent>(v5);
        v2
    }

    public fun repay_base<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T0>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T0>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 10);
        repay<T0, T1, T0>(arg0, arg2, arg3, arg4, arg5)
    }

    public fun repay_quote<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T1>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg5);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T1>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0), 10);
        repay<T0, T1, T1>(arg0, arg2, arg3, arg4, arg5)
    }

    fun repay_withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        validate_owner<T0, T1>(arg0, arg2);
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    public fun risk_ratio<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg5: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T0>, arg6: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T1>, arg7: &0x2::clock::Clock) : u64 {
        if (arg0.borrowed_base_shares > 0) {
            risk_ratio_int<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
        } else {
            risk_ratio_int<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7)
        }
    }

    fun risk_ratio_int<T0, T1, T2>(arg0: &MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg5: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T2>, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T2>(arg5);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0) || 0x1::option::is_none<0x2::object::ID>(&arg0.margin_pool_id), 10);
        let (v1, _, _) = assets_in_debt_unit<T0, T1>(arg0, arg1, arg4, arg2, arg3, arg6);
        let v4 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::borrow_shares_to_amount<T2>(arg5, 0x1::u64::max(arg0.borrowed_base_shares, arg0.borrowed_quote_shares), arg6);
        let v5 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_constants::max_risk_ratio();
        if (v1 > 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v4, v5)) {
            v5
        } else {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(v1, v4)
        }
    }

    public fun share<T0, T1>(arg0: MarginManager<T0, T1>, arg1: ManagerInitializer) {
        assert!(id<T0, T1>(&arg0) == arg1.margin_manager_id, 11);
        0x2::transfer::share_object<MarginManager<T0, T1>>(arg0);
        let ManagerInitializer {  } = arg1;
    }

    public(friend) fun trade_proof<T0, T1>(arg0: &mut MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::TradeProof {
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg1)
    }

    fun validate_owner<T0, T1>(arg0: &MarginManager<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut MarginManager<T0, T1>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T0>, arg3: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::MarginPool<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        validate_owner<T0, T1>(arg0, arg9);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T0>(arg2);
        if (0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v0)) {
            assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::can_withdraw(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg6), risk_ratio_int<T0, T1, T0>(arg0, arg1, arg4, arg5, arg6, arg2, arg8)), 8);
        } else {
            let v1 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool::id<T1>(arg3);
            if (0x1::option::contains<0x2::object::ID>(&arg0.margin_pool_id, &v1)) {
                assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::can_withdraw(arg1, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::pool::id<T0, T1>(arg6), risk_ratio_int<T0, T1, T1>(arg0, arg1, arg4, arg5, arg6, arg3, arg8)), 8);
            };
        };
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::balance_manager::withdraw_with_cap<T2>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg7, arg9)
    }

    // decompiled from Move bytecode v6
}

