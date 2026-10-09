module 0x7043851f585e6ec63c63159c8ffd40b8787ed0181745e298a363901f363d5de4::test_migrator {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun migrate<T0, T1>(arg0: &mut 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::Presale<T0, T1>, arg1: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::migrate<T0, T1, Witness>(arg0, arg1, v0, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg4), arg2);
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::creation_policy::CreationPolicy, arg2: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy) : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::PresaleInitializer<T0, T1> {
        let v0 = Witness{dummy_field: false};
        0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::new<T0, T1, Witness>(arg0, v0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

