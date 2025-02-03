module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin {
    fun assert_cooldown<T0, T1>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: bool) {
        if (arg1) {
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::assert_not_long_cd<T0, T1>(arg0);
        } else {
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::assert_not_short_cd<T0, T1>(arg0);
        };
    }

    fun assert_oi<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: u64) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::assert_oi_limit<T0, T1>(arg1, (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::iou_supply_value<T0, T1, T2>(arg0), arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg1)) as u64));
    }

    fun assert_position_notional_limit<T0, T1>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let (v0, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_position(arg1, arg2, arg3);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::assert_position_notional_limit<T0, T1>(arg0, (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::add(v0, arg4), arg5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0)) as u64));
    }

    public fun check<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: u64, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>) : (bool, u64) {
        let (v0, v1) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liabilities<T0, T2>(arg2);
        let (v2, v3, v4, v5) = 0xdee9::clob_v2::account_balance<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg2));
        let v6 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0);
        let v7 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_assets(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::add(v2, v3), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::add(v4, v5), arg1, 1, v6);
        let (v8, v9) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_position(v2, v3, v1);
        let v10 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_mm(arg1, v8, v6, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::max_mm_ratio<T0, T1>(arg0));
        let (v11, v12) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::limit_order_notional<T0, T2>(arg2);
        let v13 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_im(arg1, v8, v9, v11, v12, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::max_im_ratio<T0, T1>(arg0));
        let v14 = (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(v1, arg1, v6) as u64) + v0;
        if (v7 >= 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::add_3(v14, v10, v13)) {
            (true, v7 - 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::add_3(v14, v10, v13))
        } else {
            (false, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::add_3(v14, v10, v13) - v7)
        }
    }

    fun is_reduce_order(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : (bool, bool) {
        let (v0, v1) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_position(arg0, arg1, arg2);
        if (v0 == 0) {
            return (false, false)
        };
        if (arg9 == v1) {
            return (false, false)
        };
        let v2 = v1 && arg5 > arg0 || arg6 + arg4 > (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(v0, arg7, arg8) as u64);
        (true, v2)
    }

    fun run_margin_checks<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: u64) {
        let (v0, v1) = check<T0, T1, T2>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(arg2), arg1);
        assert!(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_margin());
        assert!((0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::multiply_as_u128(v1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::max_im_ratio<T0, T1>(arg0)) as u64) >= arg3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_margin());
    }

    public(friend) fun take<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg3: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(&arg3);
        let v1 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0);
        if (arg8 != 2) {
            let v2 = arg6 % 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::lot_size<T0, T1>(arg0);
            arg6 = arg6 - v2;
        };
        let (v3, v4) = if (arg8 == 1) {
            let v5 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::scale_db_to_pr_price(arg7, v1);
            ((0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(arg6, 0x2::math::max(v0, v5), v1) as u64), (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(arg6, v5, v1) as u64))
        } else {
            let v6 = (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(arg6, v0, v1) as u64);
            (v6, v6)
        };
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::assert_order_notional_limit<T0, T1>(arg0, v4);
        let v7 = 0x2::coin::zero<T1>(arg9);
        let v8 = 0x2::coin::zero<T0>(arg9);
        let v9 = arg6;
        let (v10, v11, v12, v13) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
        let v14 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liability<T0, T2>(arg2, false);
        let (v15, v16) = is_reduce_order(v10, v11, v14, v12, v13, arg6, v4, v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0), arg5);
        assert!(!v16, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::position_reversal_not_allowed());
        if (v15) {
            run_margin_checks<T0, T1, T2>(arg0, arg2, &arg3, 0);
        } else {
            run_margin_checks<T0, T1, T2>(arg0, arg2, &arg3, v3);
            assert_cooldown<T0, T1>(arg0, arg5);
        };
        if (arg8 == 1) {
            run_margin_checks<T0, T1, T2>(arg0, arg2, &arg3, v3);
        };
        if (arg5) {
            let v17 = if (arg8 == 2) {
                v4
            } else {
                0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::mul(v4, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::bid_order_matching_slippage_limit<T0, T1>(arg0)) / 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::order_matching_slippage_scaling()
            };
            let (v18, v19) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::sub(v12, v17);
            if (!v18) {
                0x2::coin::join<T1>(&mut v7, 0x2::coin::from_balance<T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::take_debt_kusd<T0, T1, T2>(arg1, v19), arg9));
                0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_liability<T0, T2>(arg2, v19, true, arg9);
                if (arg8 == 0 && v12 > 0) {
                    0x2::coin::join<T1>(&mut v7, 0xdee9::clob_v2::withdraw_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v12, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg2), arg9));
                };
            } else if (arg8 == 0) {
                0x2::coin::join<T1>(&mut v7, 0xdee9::clob_v2::withdraw_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v17, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg2), arg9));
            };
            if (arg8 == 0) {
                v9 = v4;
            };
        } else {
            let (v20, v21) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::sub(v10, arg6);
            if (!v20) {
                0x2::coin::join<T0>(&mut v8, 0x2::coin::from_balance<T0>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::take_debt_iou<T0, T1, T2>(arg1, v21), arg9));
                0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_liability<T0, T2>(arg2, v21, false, arg9);
                if (arg8 == 0 && v10 > 0) {
                    0x2::coin::join<T0>(&mut v8, 0xdee9::clob_v2::withdraw_base<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v10, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg2), arg9));
                };
            } else if (arg8 == 0) {
                0x2::coin::join<T0>(&mut v8, 0xdee9::clob_v2::withdraw_base<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), arg6, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg2), arg9));
            };
            if (arg8 == 0) {
                v9 = 0x2::coin::value<T0>(&v8);
            };
        };
        if (!v15) {
            assert_oi<T0, T1, T2>(arg1, arg0, v0);
            assert_position_notional_limit<T0, T1>(arg0, v10, v11, v14, arg6, v0);
        };
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::burn<T0>(arg3, arg4);
        (v8, v7, v9)
    }

    // decompiled from Move bytecode v6
}

