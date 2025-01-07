module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::deposit {
    struct DepositEvent<phantom T0> has copy, drop, store {
        account_id: 0x2::object::ID,
        amount: u64,
        account_state: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>,
        timestamp: u64,
    }

    public fun deposit_collateral<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::KriyaAccountCap, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg6);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::borrow_mut<T2>(arg2, arg3);
        0x2::event::emit<DepositEvent<T0>>(deposit_collateral_int<T0, T1, T2>(arg4, v0, arg0, arg1, arg5, arg7));
    }

    fun deposit_collateral_int<T0, T1, T2>(arg0: 0x2::coin::Coin<T2>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DepositEvent<T0> {
        let v0 = 0x2::coin::value<T2>(&arg0);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_deposits<T0, T2>(arg1, v0, arg5);
        0xdee9::clob_v2::deposit_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg3), 0x2::coin::from_balance<T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::deposit_collateral<T0, T1, T2>(arg2, 0x2::coin::into_balance<T2>(arg0)), arg5), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg1));
        let v1 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::settle<T0, T1, T2>(arg1, arg2, arg3, true, arg5);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::set_last_deposit_timestamp<T0, T2>(arg1, 0x2::clock::timestamp_ms(arg4));
        DepositEvent<T0>{
            account_id    : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::id<T2>(arg1),
            amount        : v0,
            account_state : 0x1::option::extract<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account::AccountState<T0>>(&mut v1),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        }
    }

    // decompiled from Move bytecode v6
}

