module 0x699fc2b8261216ba92c51f1b6f727498a76e93a5170f7aaf9a0f5652d116f535::coinz {
    struct StoredCoin<T0: store> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    public fun zero<T0: store>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StoredCoin<T0>{
            id   : 0x2::object::new(arg0),
            coin : 0x2::coin::zero<T0>(arg0),
        };
        0x2::transfer::public_share_object<StoredCoin<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

