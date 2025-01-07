module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::cancel_order {
    struct OrderCancelledEvent<phantom T0> has copy, drop, store {
        account_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        timestamp: u64,
    }

    public fun cancel_order<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg6);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow_mut<T2>(arg2, arg3);
        0x2::event::emit<OrderCancelledEvent<T0>>(cancel_order_int<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg7));
    }

    fun batch_cancel_order_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : OrderCancelledEvent<T0> {
        while (0x1::vector::length<u64>(&arg3) > 0) {
            cancel_order_int<T0, T1, T2>(arg0, arg1, arg2, 0x1::vector::pop_back<u64>(&mut arg3), arg4, arg5);
        };
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(arg2, arg1, arg0, true, arg5);
        OrderCancelledEvent<T0>{
            account_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v0),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        }
    }

    public fun batch_cancel_orders<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg6);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow_mut<T2>(arg2, arg3);
        0x2::event::emit<OrderCancelledEvent<T0>>(batch_cancel_order_int<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg7));
    }

    fun cancel_order_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : OrderCancelledEvent<T0> {
        let v0 = 0xdee9::clob_v2::get_order_status<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0), arg3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg2));
        let v1 = 0xdee9::clob_v2::is_bid(v0);
        let v2 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::dec_open_order_notional<T0, T2>(arg2, (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(0xdee9::clob_v2::quantity(v0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::scale_db_to_pr_price(0xdee9::clob_v2::tick_level(v0), v2), v2) as u64), v1);
        0xdee9::clob_v2::cancel_order<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), arg3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap_mut<T2>(arg2));
        let v3 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(arg2, arg1, arg0, true, arg5);
        OrderCancelledEvent<T0>{
            account_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v3),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        }
    }

    // decompiled from Move bytecode v6
}

