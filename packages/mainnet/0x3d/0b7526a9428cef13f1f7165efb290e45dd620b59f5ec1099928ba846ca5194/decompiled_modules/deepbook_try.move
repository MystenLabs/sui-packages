module 0x3d0b7526a9428cef13f1f7165efb290e45dd620b59f5ec1099928ba846ca5194::deepbook_try {
    struct ContractData has store, key {
        id: 0x2::object::UID,
    }

    public fun deepbookswap_0<T0, T1>(arg0: u64, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, arg2, arg4, 0x2::coin::value<T0>(&arg5) / arg6 * arg6, false, arg5, 0x2::coin::zero<T1>(arg7), arg3, arg7);
        transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg7));
        v1
    }

    public fun deepbookswap_1<T0, T1>(arg0: u64, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg1, arg4, arg2, 0x2::coin::value<T1>(&arg5), arg3, arg5, arg6);
        transfer_or_destroy_zero<T1>(v1, 0x2::tx_context::sender(arg6));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun transfer_coins_with_threshold_2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

