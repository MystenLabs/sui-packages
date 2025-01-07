module 0xfff78b2d0ea9fc2e0a09ceb946a151c7d6e835114f76f075881148a5463d4e8::flash_task {
    public fun flash_task<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdee9::clob_v2::create_account(arg6);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, arg1, &v0);
        0xdee9::clob_v2::deposit_quote<T0, T1>(arg0, arg2, &v0);
        let v1 = 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, 0x2::coin::value<T0>(&arg1), &v0, arg6);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg4, &v0, arg3, 0x2::coin::split<T0>(&mut v1, arg3, arg6), 0x2::coin::zero<T1>(arg6), arg5, arg6);
        let v5 = v3;
        0x2::coin::destroy_zero<T0>(v2);
        let (v6, v7, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg4, &v0, 0x2::coin::value<T1>(&v5), arg5, v5, arg6);
        0x2::coin::destroy_zero<T1>(v7);
        0xdee9::custodian_v2::delete_account_cap(v0);
        0x2::coin::join<T0>(&mut v1, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), &v0, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

