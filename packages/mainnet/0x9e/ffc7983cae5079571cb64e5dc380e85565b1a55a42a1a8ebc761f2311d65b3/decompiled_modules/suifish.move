module 0x9effc7983cae5079571cb64e5dc380e85565b1a55a42a1a8ebc761f2311d65b3::suifish {
    struct SUIFISH has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUIFISH", b"SUI FISH SUI LOVE", b"SUIFISH sui love is now for the most and everybody will be able to send the can", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gray-distinctive-walrus-769.mypinata.cloud/ipfs/QmTTeaBzyCCXWkYeH3SF3k3VrDSwheKxVFCcf1TpSM3V1D")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUIFISH>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUIFISH>(&mut v0, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

