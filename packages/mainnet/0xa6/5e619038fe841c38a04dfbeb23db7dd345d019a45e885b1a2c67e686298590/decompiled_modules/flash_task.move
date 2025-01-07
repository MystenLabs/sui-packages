module 0xa65e619038fe841c38a04dfbeb23db7dd345d019a45e885b1a2c67e686298590::flash_task {
    public fun flash_task<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdee9::clob_v2::create_account(arg6);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, arg1, &v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, arg2, &v0);
        let v1 = 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, 0x2::coin::value<T0>(&arg1), &v0, arg6);
        let v2 = 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), &v0, arg6);
        let (v3, v4, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg4, &v0, arg3, 0x2::coin::split<T0>(&mut v1, arg3, arg6), 0x2::coin::zero<T1>(arg6), arg5, arg6);
        let v6 = v4;
        0x2::coin::join<T0>(&mut v1, v3);
        let (v7, v8, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg4, &v0, 0x2::coin::value<T1>(&v6), arg5, v6, arg6);
        0x2::coin::join<T1>(&mut v2, v8);
        0xdee9::custodian_v2::delete_account_cap(v0);
        0x2::coin::join<T0>(&mut v1, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

