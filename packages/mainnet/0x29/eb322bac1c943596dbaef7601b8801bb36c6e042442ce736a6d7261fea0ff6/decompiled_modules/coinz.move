module 0x29eb322bac1c943596dbaef7601b8801bb36c6e042442ce736a6d7261fea0ff6::coinz {
    struct ZeroCoin<T0: store> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    public fun zero<T0: store>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ZeroCoin<T0>{
            id   : 0x2::object::new(arg0),
            coin : 0x2::coin::zero<T0>(arg0),
        };
        0x2::transfer::public_share_object<ZeroCoin<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

