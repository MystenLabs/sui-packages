module 0x1dbc217f27a68bf980ef3388494e23588804c1c44e01d3a6e33c19486053917b::deepbook {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x1dbc217f27a68bf980ef3388494e23588804c1c44e01d3a6e33c19486053917b::i_have_too_much_money::Vault, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg1, 0, 0x1dbc217f27a68bf980ef3388494e23588804c1c44e01d3a6e33c19486053917b::i_have_too_much_money::deepbook_account(arg0), 0x2::coin::value<T0>(&arg2), arg2, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        if (v4 > 0) {
            0x1dbc217f27a68bf980ef3388494e23588804c1c44e01d3a6e33c19486053917b::i_have_too_much_money::deposit<T0>(arg0, &mut v3, v4, arg4);
        };
        0x2::coin::destroy_zero<T0>(v3);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x1dbc217f27a68bf980ef3388494e23588804c1c44e01d3a6e33c19486053917b::i_have_too_much_money::Vault, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg1, 0, 0x1dbc217f27a68bf980ef3388494e23588804c1c44e01d3a6e33c19486053917b::i_have_too_much_money::deepbook_account(arg0), 0x2::coin::value<T1>(&arg2), arg3, arg2, arg4);
        let v3 = v1;
        let v4 = 0x2::coin::value<T1>(&v3);
        if (v4 > 0) {
            0x1dbc217f27a68bf980ef3388494e23588804c1c44e01d3a6e33c19486053917b::i_have_too_much_money::deposit<T1>(arg0, &mut v3, v4, arg4);
        };
        0x2::coin::destroy_zero<T1>(v3);
        v0
    }

    // decompiled from Move bytecode v6
}

