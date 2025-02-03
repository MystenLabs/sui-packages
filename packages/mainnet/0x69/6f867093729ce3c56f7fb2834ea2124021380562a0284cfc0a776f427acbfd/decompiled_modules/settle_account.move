module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::settle_account {
    struct AccountStateEvent<phantom T0> has copy, drop, store {
        state: AccountState<T0>,
    }

    struct AccountState<phantom T0> has copy, drop, store {
        account_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        iou_liability: u64,
        usd_liability: u64,
        deepbook_iou_locked: u64,
        deepbook_iou_avail: u64,
        deepbook_kusd_locked: u64,
        deepbook_kusd_avail: u64,
    }

    public(friend) fun settle<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::Account<T2>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<AccountState<T0>> {
        let (v0, v1) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liabilities<T0, T2>(arg0);
        let v2 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg2);
        let (v3, _, v5, _) = 0xdee9::clob_v2::account_balance<T0, T1>(v2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg0));
        if (v0 > 0 && v5 > 0) {
            let v7 = if (v0 > v5) {
                v5
            } else {
                v0
            };
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::repay_debt_kusd<T0, T1, T2>(arg1, 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_quote<T0, T1>(v2, v7, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg0), arg4)));
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::dec_liability<T0, T2>(arg0, v7, true);
        };
        if (v1 > 0 && v3 > 0) {
            let v8 = if (v1 > v3) {
                v3
            } else {
                v1
            };
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::repay_debt_iou<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(0xdee9::clob_v2::withdraw_base<T0, T1>(v2, v8, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg0), arg4)));
            0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::dec_liability<T0, T2>(arg0, v8, false);
        };
        let (v9, v10) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liabilities<T0, T2>(arg0);
        let (v11, v12, v13, v14) = 0xdee9::clob_v2::account_balance<T0, T1>(v2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(arg0));
        if (arg3) {
            let v16 = AccountState<T0>{
                account_id           : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::id<T2>(arg0),
                account_cap_id       : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap_id<T2>(arg0),
                iou_liability        : v10,
                usd_liability        : v9,
                deepbook_iou_locked  : v12,
                deepbook_iou_avail   : v11,
                deepbook_kusd_locked : v14,
                deepbook_kusd_avail  : v13,
            };
            0x1::option::some<AccountState<T0>>(v16)
        } else {
            0x1::option::none<AccountState<T0>>()
        }
    }

    public fun settle_public<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg1: 0x2::object::ID, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg4: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg4);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg0, arg1);
        let v1 = settle<T0, T1, T2>(v0, arg2, arg3, true, arg5);
        let v2 = AccountStateEvent<T0>{state: 0x1::option::extract<AccountState<T0>>(&mut v1)};
        0x2::event::emit<AccountStateEvent<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

