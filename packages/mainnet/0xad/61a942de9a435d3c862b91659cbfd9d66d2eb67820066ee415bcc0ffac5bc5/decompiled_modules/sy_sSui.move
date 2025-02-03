module 0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy_sSui {
    public entry fun create<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::create<T0>(9, b"sSUI", b"scallop sSUI", arg0);
    }

    public fun deposit<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::deposit<T0>(arg0, v0, arg2, 0x2::balance::value<T0>(&v0), arg3, arg4);
    }

    public fun deposit_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYCoin<T0>> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::deposit_with_coin_back<T0>(arg0, v0, arg2, 0x2::balance::value<T0>(&v0), arg3, arg4)
    }

    public fun redeem<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYCoin<T0>>, arg2: u64, arg3: &mut 0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYCoin<T0>>(arg1);
        0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::redeem<T0>(arg0, v0, arg2, 0x2::balance::value<0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYCoin<T0>>(&v0), arg3, arg4);
    }

    public fun redeem_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::coin::Coin<0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYCoin<T0>>, arg2: u64, arg3: &mut 0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYCoin<T0>>(arg1);
        0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::redeem_with_coin_back<T0>(arg0, v0, arg2, 0x2::balance::value<0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::sy::SYCoin<T0>>(&v0), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

