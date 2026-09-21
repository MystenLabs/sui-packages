module 0x723ba678843f6a779448f1084a9a818862195883b2ef354266828ad43cdef3e0::karat {
    struct KARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARAT>(arg0, 9, b"KARAT", b"Seventeen Karat", b"Seventeen Karat SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/f191f9761ef2cdbd0f908154b83b05b3f3944ca13557554b6ac5998a0861dab4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KARAT>>(0x2::coin::mint<KARAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KARAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARAT>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

