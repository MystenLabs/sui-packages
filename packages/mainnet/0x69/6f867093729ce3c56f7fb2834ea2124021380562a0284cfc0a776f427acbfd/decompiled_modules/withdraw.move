module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::withdraw {
    struct WithdrawEvent<phantom T0> has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        account_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        timestamp: u64,
    }

    struct WithdrawRequestAddedEvent<phantom T0> has copy, drop {
        for: 0x2::object::ID,
        amount: u64,
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg6);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow_mut<T2>(arg1, arg2);
        let (v1, v2) = withdraw_int<T0, T1, T2>(arg0, v0, arg3, arg4, arg5, arg7);
        0x2::event::emit<WithdrawEvent<T0>>(v2);
        v1
    }

    fun getAllowedWithdrawalAmount<T0, T1>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_position(arg1, arg2, arg3);
        let (v2, v3) = if (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::info_exists<T0, T1>(arg0)) {
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::pnl_info<T0, T1>(arg0)
        } else {
            (0, true)
        };
        let v4 = if (v0 > 0) {
            let v5 = if (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::total_deposits<T0, T1>(arg0) > 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::total_withdrawals<T0, T1>(arg0)) {
                0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::total_deposits<T0, T1>(arg0) - 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::total_withdrawals<T0, T1>(arg0)
            } else {
                0
            };
            0x2::math::min(arg4, v5)
        } else {
            arg4
        };
        let (v6, v7) = if (v3) {
            (v2, v4)
        } else if (v2 > v4) {
            (0, 0)
        } else {
            (0, v4 - v2)
        };
        (v7, v6)
    }

    public fun process_request<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg2: 0x2::object::ID, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg5: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg5);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::verify<T0>(arg3);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg1, arg2);
        process_request_int<T0, T1, T2>(arg0, v0, arg3, arg4, arg6);
    }

    fun process_request_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::wr_exist<T0, T1, T2>(arg3)) {
            let (v0, v1) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::unwrap_withdraw_request(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::pop_withdrawal_request<T0, T1, T2>(arg3));
            assert!(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::id<T2>(arg1) == v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_account());
            let (v2, v3) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::check<T0, T1, T2>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(arg2), arg1);
            if (v2) {
                let (_, v5) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liabilities<T0, T2>(arg1);
                let (v6, v7, v8, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
                let (v10, v11) = getAllowedWithdrawalAmount<T0, T2>(arg1, v6, v7, v5, v3);
                if (v10 + v11 >= v1) {
                    process_withdrawal<T0, T1, T2>(arg0, arg1, arg3, v1, v10, v8, arg4);
                };
            };
        };
    }

    fun process_withdrawal<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 >= arg3) {
            0xdee9::clob_v2::withdraw_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), arg3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg1), arg6)
        } else {
            let v1 = if (arg5 > 0) {
                0xdee9::clob_v2::withdraw_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), arg5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg1), arg6)
            } else {
                0x2::coin::zero<T1>(arg6)
            };
            let v2 = v1;
            0x2::coin::join<T1>(&mut v2, 0x2::coin::from_balance<T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::take_debt_kusd<T0, T1, T2>(arg2, arg3 - arg5), arg6));
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_liability<T0, T2>(arg1, arg3 - arg5, true, arg6);
            v2
        };
        let v3 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::withdraw_collateral<T0, T1, T2>(arg2, 0x2::coin::into_balance<T1>(v0));
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_withdrawals<T0, T2>(arg1, 0x2::balance::value<T2>(&v3));
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_processed_withdrawals<T0, T2>(arg1, v3);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(arg1, arg2, arg0, false, arg6);
        if (arg3 > arg4) {
            assert!(arg3 - arg4 <= 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::pnl_pool_size<T0, T1, T2>(arg2), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_pnl_funds());
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::dec_pnl_pool<T0, T1, T2>(arg2, arg3 - arg4);
        };
    }

    public fun request<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg5: u64, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg6);
        assert!(arg5 > 0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_request());
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::verify<T0>(arg3);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow_mut<T2>(arg1, arg2);
        request_int<T0, T1, T2>(arg0, v0, arg3, arg4, arg5);
        let v1 = WithdrawRequestAddedEvent<T0>{
            for    : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::id<T2>(v0),
            amount : arg5,
        };
        0x2::event::emit<WithdrawRequestAddedEvent<T0>>(v1);
    }

    fun request_int<T0, T1, T2>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg4: u64) {
        let (v0, v1) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::margin::check<T0, T1, T2>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(arg2), arg1);
        assert!(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_margin());
        let (_, v3) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liabilities<T0, T2>(arg1);
        let (v4, v5, _, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
        let (v8, v9) = getAllowedWithdrawalAmount<T0, T2>(arg1, v4, v5, v3, v1);
        assert!(arg4 <= v8 + v9, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_w_cash());
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::push_withdrawal_request<T0, T1, T2>(arg3, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::id<T2>(arg1), arg4);
    }

    entry fun withdraw_entry<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg6);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow_mut<T2>(arg1, arg2);
        let (v1, v2) = withdraw_int<T0, T1, T2>(arg0, v0, arg3, arg4, arg5, arg7);
        0x2::event::emit<WithdrawEvent<T0>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg7));
    }

    fun withdraw_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, WithdrawEvent<T0>) {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::withdraw_processed<T0, T2>(arg1, arg3);
        let v1 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(arg1, arg2, arg0, true, arg5);
        let v2 = WithdrawEvent<T0>{
            account_id    : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::id<T2>(arg1),
            amount        : 0x2::balance::value<T2>(&v0),
            account_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v1),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        (0x2::coin::from_balance<T2>(v0, arg5), v2)
    }

    // decompiled from Move bytecode v6
}

