module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper {
    public fun account_balance<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64, u64) {
        0xdee9::clob_v2::account_balance<T0, T1>(arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg0))
    }

    public fun account_open_orders<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: 0x2::object::ID) : vector<0xdee9::clob_v2::Order> {
        open_orders<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg0, arg2), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg1))
    }

    fun adjust_realised_pnl(arg0: bool, arg1: u64, arg2: bool, arg3: u64) : (u64, bool) {
        if (arg0 == true && arg1 == 0) {
            arg0 = arg2;
            arg1 = arg3;
        } else if (arg0 == arg2) {
            arg1 = arg1 + arg3;
        } else if (arg1 >= arg3) {
            arg1 = arg1 - arg3;
        } else {
            arg1 = arg3 - arg1;
            arg0 = arg2;
        };
        (arg1, arg0)
    }

    fun calc_realized_pnl(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : (u64, bool) {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0 - arg1, true)
        } else {
            (arg1 - arg0, false)
        };
        ((0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::scale_db_to_pr_price(v0, arg4), arg4) as u64), v1 == arg3)
    }

    public fun deepbook_balance<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: 0x2::object::ID) : (u64, u64, u64, u64) {
        account_balance<T0, T1, T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow<T2>(arg0, arg2), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg1))
    }

    public fun open_orders<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : vector<0xdee9::clob_v2::Order> {
        0xdee9::clob_v2::list_open_orders<T0, T1>(arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg0))
    }

    public(friend) fun process_matched_order<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder, arg3: u64, arg4: bool) {
        let (v0, v1, v2, v3) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::info(&arg2);
        let v4 = v1;
        if (arg4) {
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::dec_open_order_notional<T0, T2>(arg0, (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(v1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::scale_db_to_pr_price(v2, arg3), arg3) as u64), v3);
        };
        let v5 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::mo_history_mut<T0, T2>(arg0);
        let v6 = 0x2::linked_table::front<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5);
        if (0x1::option::is_some<u64>(v6)) {
            let v7 = 0;
            let v8 = true;
            let v9 = *v6;
            let v10 = 0x1::option::extract<u64>(&mut v9);
            let (_, _, _, v14) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::info(0x2::linked_table::borrow<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5, v10));
            if (v14 == v3) {
                0x2::linked_table::push_back<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5, v0, arg2);
            } else {
                loop {
                    let v15 = 0x2::linked_table::borrow_mut<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5, v10);
                    let (_, v17, v18, v19) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::info(v15);
                    let (v20, v21) = calc_realized_pnl(v2, v18, 0x2::math::min(v4, v17), v19, arg3);
                    let (v22, v23) = adjust_realised_pnl(v8, v7, v21, v20);
                    v7 = v22;
                    v8 = v23;
                    if (v4 < v17) {
                        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::update_quantity(v15, v17 - v4);
                        break
                    };
                    if (v4 == v17) {
                        let (_, _) = 0x2::linked_table::pop_front<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5);
                        break
                    };
                    v4 = v4 - v17;
                    let (_, _) = 0x2::linked_table::pop_front<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5);
                    let v28 = 0x2::linked_table::front<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5);
                    if (0x1::option::is_some<u64>(v28)) {
                        let v29 = *v28;
                        v10 = 0x1::option::extract<u64>(&mut v29);
                    } else {
                        break
                    };
                };
            };
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::set_pnl_info<T0, T2>(arg0, v7, v8);
            if (!v8) {
                0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::inc_pnl_pool<T0, T1, T2>(arg1, v7);
            };
        } else {
            0x2::linked_table::push_back<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(v5, v0, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

