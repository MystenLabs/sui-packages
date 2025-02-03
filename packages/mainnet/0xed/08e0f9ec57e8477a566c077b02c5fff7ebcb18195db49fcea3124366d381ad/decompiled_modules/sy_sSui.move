module 0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy_sSui {
    public entry fun create<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::create<T0>(9, b"sSUI", b"scallop sSUI", arg0);
    }

    public fun deposit<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::deposit<T0>(arg0, v0, arg2, 0x2::balance::value<T0>(&v0), arg3, arg4);
    }

    public fun deposit_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYCoin<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::deposit_with_coin_back<T0>(arg0, v0, arg2, 0x2::balance::value<T0>(&v0), arg3, arg4)
    }

    public fun redeem<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYCoin<T0>>, arg2: u64, arg3: &mut 0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYCoin<T0>>(arg1);
        0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::redeem<T0>(arg0, v0, arg2, 0x2::balance::value<0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYCoin<T0>>(&v0), arg3, arg4);
    }

    public fun redeem_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYCoin<T0>>, arg2: u64, arg3: &mut 0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYCoin<T0>>(arg1);
        0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::redeem_with_coin_back<T0>(arg0, v0, arg2, 0x2::balance::value<0xed08e0f9ec57e8477a566c077b02c5fff7ebcb18195db49fcea3124366d381ad::sy::SYCoin<T0>>(&v0), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

