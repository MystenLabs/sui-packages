module 0xdf405c7fb5f345e94365e56baecd8c97762673838f7ad16413a60e0588ea0455::account_cap {
    public fun destroy_account_cap<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0xdee9::custodian_v2::AccountCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xdee9::clob_v2::cancel_all_orders<T0, T1>(arg0, &arg1);
        let (v0, _, v2, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, &arg1);
        let v4 = if (v2 > 0) {
            0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v2, &arg1, arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        };
        let v5 = if (v0 > 0) {
            0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v0, &arg1, arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        };
        0xdee9::custodian_v2::delete_account_cap(arg1);
        (v5, v4)
    }

    public entry fun destroy_account_cap_entry<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0xdee9::custodian_v2::AccountCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = destroy_account_cap<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

