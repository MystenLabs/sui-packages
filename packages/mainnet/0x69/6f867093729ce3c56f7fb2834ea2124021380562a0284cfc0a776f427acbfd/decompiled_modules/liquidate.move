module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::liquidate {
    struct LiquidationEvent<phantom T0> has copy, drop, store {
        account_cap_id: 0x2::object::ID,
        liquidator_account_cap_id: 0x2::object::ID,
        mark_price: u64,
        liq_size: u64,
        account_to_liq_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        liquidator_acc_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        timestamp: u64,
    }

    struct LiquidationCancelOrderEvent<phantom T0> has copy, drop, store {
        account_cap_id: 0x2::object::ID,
        account_to_liq_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg5: 0x2::object::ID, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg9);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::verify<T0>(&arg2);
        liquidate_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::access_to(arg6), arg7, arg8, arg10);
    }

    public fun batch_cancel_orders_liqee<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg5: 0x2::object::ID, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg8);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::verify<T0>(&arg2);
        batch_cancel_orders_liqee_int<T0, T1, T2>(arg0, arg1, &arg2, arg4, arg5, arg6, arg7, arg9);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::burn<T0>(arg2, arg3);
    }

    fun batch_cancel_orders_liqee_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg4: 0x2::object::ID, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (run_checks<T0, T1, T2>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg3, arg4), arg2)) {
            0xdee9::clob_v2::batch_cancel_order<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), arg5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg3, arg4)));
            let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg3, arg4), arg1, arg0, true, arg7);
            let v1 = LiquidationCancelOrderEvent<T0>{
                account_cap_id       : arg4,
                account_to_liq_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v0),
                timestamp            : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<LiquidationCancelOrderEvent<T0>>(v1);
        };
    }

    fun cancel_open_orders<T0, T1, T2>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>) {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg1);
        let (_, v2, _, v4) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, v0);
        if (v2 > 0 || v4 > 0) {
            0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg0, v0);
        };
    }

    public fun cancel_orders_liqee<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg7);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::verify<T0>(&arg2);
        cancel_orders_liqee_int<T0, T1, T2>(arg0, arg1, &arg2, arg4, arg5, arg6, arg8);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::burn<T0>(arg2, arg3);
    }

    fun cancel_orders_liqee_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (run_checks<T0, T1, T2>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg3, arg4), arg2)) {
            let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0);
            cancel_open_orders<T0, T1, T2>(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg3, arg4));
            let v1 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg3, arg4), arg1, arg0, true, arg6);
            let v2 = LiquidationCancelOrderEvent<T0>{
                account_cap_id       : arg4,
                account_to_liq_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v1),
                timestamp            : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<LiquidationCancelOrderEvent<T0>>(v2);
        };
    }

    fun liquidate_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        cancel_orders_liqee_int<T0, T1, T2>(arg0, arg1, &arg2, arg4, arg5, arg8, arg9);
        if (run_checks<T0, T1, T2>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5), &arg2)) {
            let (v0, v1, v2, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
            let (v4, v5) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_position(v0, v1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liability<T0, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5), false));
            assert!(arg7 == 0 || arg7 >= v4 / 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::min_liq_ratio<T0, T1>(arg0) && arg7 <= v4, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::min_liq_size_required());
            let (_, _, _, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg6), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
            let v10 = if (arg7 > 0) {
                arg7
            } else {
                v4
            };
            let v11 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(&arg2);
            assert!(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::get_last_deposit_timestamp<T0, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5)) < 0x2::clock::timestamp_ms(arg8), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::deposit_cooldown_not_completed());
            let (v12, v13, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::take<T0, T1, T2>(arg0, arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg4, arg6), arg2, arg3, v5, v10, 0, 2, arg9);
            let v15 = v13;
            let v16 = v12;
            if (v5) {
                0xdee9::clob_v2::deposit_base<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), 0xdee9::clob_v2::withdraw_base<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), size_with_fee(v4, v10, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::liq_fee<T0, T1>(arg0)), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5)), arg9), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg6)));
            } else {
                let v17 = (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(size_with_fee(v4, v10, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::liq_fee<T0, T1>(arg0)), v11, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0)) as u64);
                let v18 = if (v17 > v2) {
                    v2
                } else {
                    v17
                };
                0xdee9::clob_v2::deposit_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), 0xdee9::clob_v2::withdraw_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v18, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5)), arg9), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg6)));
            };
            if (0x2::coin::value<T0>(&v16) > 0) {
                0xdee9::clob_v2::deposit_base<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v16, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5)));
            } else {
                0x2::coin::destroy_zero<T0>(v16);
            };
            if (0x2::coin::value<T1>(&v15) > 0) {
                0xdee9::clob_v2::deposit_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v15, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg4, arg5)));
            } else {
                0x2::coin::destroy_zero<T1>(v15);
            };
            let v19 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg4, arg5), arg1, arg0, true, arg9);
            let v20 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg4, arg6), arg1, arg0, true, arg9);
            let v21 = LiquidationEvent<T0>{
                account_cap_id            : arg5,
                liquidator_account_cap_id : arg6,
                mark_price                : v11,
                liq_size                  : v10,
                account_to_liq_state      : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v19),
                liquidator_acc_state      : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v20),
                timestamp                 : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<LiquidationEvent<T0>>(v21);
        } else {
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::burn<T0>(arg2, arg3);
        };
    }

    fun run_checks<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>) : bool {
        let (v0, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::check<T0, T1, T2>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(arg2), arg1);
        !v0 && true
    }

    fun size_with_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 + ((((arg0 - arg1) as u128) * (arg2 as u128) / (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::liq_fee_scaling() as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

