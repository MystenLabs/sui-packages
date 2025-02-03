module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::place_order {
    struct MarketOrderPlaced<phantom T0> has copy, drop, store {
        account_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        timestamp: u64,
    }

    struct LimitOrderPlaced<phantom T0> has copy, drop, store {
        account_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        timestamp: u64,
    }

    public fun place_limit_order<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg4: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg5: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg10);
        0x2::event::emit<LimitOrderPlaced<T0>>(place_limit_order_int<T0, T1, T2>(arg1, arg0, arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::access_to(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg11));
    }

    public fun place_market_order<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg4: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg5: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg9);
        0x2::event::emit<MarketOrderPlaced<T0>>(place_market_order_int<T0, T1, T2>(arg0, arg1, arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::access_to(arg3), arg4, arg5, arg6, arg7, arg8, arg10));
    }

    fun assert_matched_price_within_range(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::scale_db_to_pr_price(arg0, arg2);
        assert!(v0 > arg1 && v0 - arg1 <= 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::safe_multiply_divide(arg1, arg3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::order_matching_mark_price_variance_scaling()) || arg1 - v0 <= 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::safe_multiply_divide(arg1, arg3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::order_matching_mark_price_variance_scaling()), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::matched_price_not_fair());
    }

    fun assert_order_reversal<T0, T1>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let (v0, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_position(arg1, arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liability<T0, T1>(arg0, false));
        let (v2, v3) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::limit_order_notional<T0, T1>(arg0);
        if (v0 == 0) {
            if (arg4 > arg3) {
                assert!(v2 > v3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::position_reversal_not_allowed());
            } else if (arg4 < arg3) {
                assert!(v2 < v3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::position_reversal_not_allowed());
            };
        };
    }

    fun calc_ema(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = arg3 - arg2;
        if (v0 >= arg4) {
            arg1
        } else {
            (((0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::multiply_as_u128(arg0, arg4 - v0) + 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::multiply_as_u128(arg1, v0)) / (arg4 as u128)) as u64)
        }
    }

    fun get_ob_mid_price<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>) : u64 {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        if (!0x1::option::is_some<u64>(&v3) || !0x1::option::is_some<u64>(&v2)) {
            return 0
        };
        ((((0x1::option::extract<u64>(&mut v3) + 0x1::option::extract<u64>(&mut v2)) as u128) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::pr_price_scaling() as u128) / 2 * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::db_price_scaling(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg1)) as u128)) as u64)
    }

    fun place_limit_order_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: 0x2::object::ID, arg4: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg5: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : LimitOrderPlaced<T0> {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg2, arg3);
        let (_, v2, _, v4) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
        let (v5, v6) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::limit_order_notional<T0, T2>(v0);
        let (v7, v8, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::take<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg6, arg7, arg8, 1, arg10);
        let v10 = v8;
        let v11 = v7;
        if (0x2::coin::value<T0>(&v11) > 0) {
            0xdee9::clob_v2::deposit_base<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v11, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0));
        } else {
            0x2::coin::destroy_zero<T0>(v11);
        };
        if (0x2::coin::value<T1>(&v10) > 0) {
            0xdee9::clob_v2::deposit_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v10, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0));
        } else {
            0x2::coin::destroy_zero<T1>(v10);
        };
        let (v12, v13, v14) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::deepbook_adapter::place_limit_order<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0), arg6, arg7, arg8, arg9, arg10);
        if (v12) {
            update_limit_order_notional<T0, T1, T2>(v0, arg0, v13);
        };
        let v15 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(v0, arg1, arg0, true, arg10);
        let (v16, v17, _, v19) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
        if (arg6) {
            assert!(v2 == v17, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::self_matching_prevention());
        } else {
            assert!(v4 == v19, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::self_matching_prevention());
        };
        assert_order_reversal<T0, T2>(v0, v16, v17, v6, v5);
        let v20 = LimitOrderPlaced<T0>{
            account_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v15),
            timestamp     : 0x2::clock::timestamp_ms(arg9),
        };
        process_matched_order_mdata_events<T0, T1, T2>(arg0, arg1, arg2, arg3, v14, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(&arg4), arg9);
        v20
    }

    fun place_market_order_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: 0x2::object::ID, arg4: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg5: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : MarketOrderPlaced<T0> {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg2, arg3);
        let (_, v2, _, v4) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg1));
        let (v5, v6) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::limit_order_notional<T0, T2>(v0);
        let (v7, v8, v9) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::take<T0, T1, T2>(arg1, arg0, v0, arg4, arg5, arg6, arg7, 0, 0, arg9);
        let (v10, v11, _, v13) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::deepbook_adapter::place_market_order<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg1), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0), arg6, v9, v7, v8, arg8, arg9);
        let v14 = v11;
        let v15 = v10;
        if (0x2::coin::value<T0>(&v15) > 0) {
            0xdee9::clob_v2::deposit_base<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg1), v15, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0));
        } else {
            0x2::coin::destroy_zero<T0>(v15);
        };
        if (0x2::coin::value<T1>(&v14) > 0) {
            0xdee9::clob_v2::deposit_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg1), v14, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0));
        } else {
            0x2::coin::destroy_zero<T1>(v14);
        };
        let v16 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(v0, arg0, arg1, true, arg9);
        let (v17, v18, _, v20) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg1));
        if (arg6) {
            assert!(v2 == v18, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::self_matching_prevention());
        } else {
            assert!(v4 == v20, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::self_matching_prevention());
        };
        assert_order_reversal<T0, T2>(v0, v17, v18, v6, v5);
        let v21 = MarketOrderPlaced<T0>{
            account_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v16),
            timestamp     : 0x2::clock::timestamp_ms(arg8),
        };
        process_matched_order_mdata_events<T0, T1, T2>(arg1, arg0, arg2, arg3, v13, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(&arg4), arg8);
        v21
    }

    fun process_matched_order_mdata_events<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: 0x2::object::ID, arg4: vector<0xdee9::clob_v2::MatchedOrderMetadata<T0, T1>>, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xdee9::clob_v2::MatchedOrderMetadata<T0, T1>>(&arg4)) {
            let (_, v2, v3, _, v5, v6, v7, _, _) = 0xdee9::clob_v2::matched_order_metadata_info<T0, T1>(0x1::vector::borrow<0xdee9::clob_v2::MatchedOrderMetadata<T0, T1>>(&arg4, v0));
            assert_matched_price_within_range(v7, arg5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::order_matching_mark_price_variance<T0, T1>(arg0));
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::process_matched_order<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg2, arg3), arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::mint(v2, v6, v7, !v3), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0), false);
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::process_matched_order<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg2, 0x2::object::id_from_address(v5)), arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::mint(v2, v6, v7, v3), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0), true);
            let (v10, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::check<T0, T1, T2>(arg0, arg5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg2, 0x2::object::id_from_address(v5)));
            assert!(v10, 0);
            if (v0 == 0x1::vector::length<0xdee9::clob_v2::MatchedOrderMetadata<T0, T1>>(&arg4) - 1) {
                let v12 = get_ob_mid_price<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0), arg0);
                update_ema_prices<T0, T1>(arg0, v7, v12, arg6);
            };
            v0 = v0 + 1;
        };
        let (v13, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::check<T0, T1, T2>(arg0, arg5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg2, arg3));
        assert!(v13, 0);
    }

    fun update_ema_prices<T0, T1>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::ob_mid_price<T0, T1>(arg0);
        let (v2, v3) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::ltp<T0, T1>(arg0);
        let v4 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::ema_calc_duration<T0, T1>(arg0);
        let (v5, v6) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::prices_updated_at<T0, T1>(arg0);
        if (v5 == 0x2::clock::timestamp_ms(arg3)) {
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_ltp<T0, T1>(arg0, calc_ema(v3, arg1, v6, 0x2::clock::timestamp_ms(arg3), v4), false);
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_ob_mid_price<T0, T1>(arg0, calc_ema(v1, arg2, v6, 0x2::clock::timestamp_ms(arg3), v4), false);
        } else {
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_ltp<T0, T1>(arg0, calc_ema(v2, arg1, v5, 0x2::clock::timestamp_ms(arg3), v4), true);
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_ob_mid_price<T0, T1>(arg0, calc_ema(v0, arg2, v5, 0x2::clock::timestamp_ms(arg3), v4), true);
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_prices_updated_at<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3));
        };
    }

    fun update_limit_order_notional<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: u64) {
        if (arg2 > 0) {
            let v0 = 0xdee9::clob_v2::get_order_status<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg1), arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg0));
            let v1 = 0xdee9::clob_v2::tick_level(v0);
            let v2 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg1);
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_open_order_notional<T0, T2>(arg0, (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(0xdee9::clob_v2::quantity(v0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::scale_db_to_pr_price(v1, v2), v2) as u64), 0xdee9::clob_v2::is_bid(v0));
        };
    }

    // decompiled from Move bytecode v6
}

