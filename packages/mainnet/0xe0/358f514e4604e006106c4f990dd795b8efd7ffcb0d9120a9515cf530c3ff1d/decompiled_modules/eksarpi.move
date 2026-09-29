module 0xe0358f514e4604e006106c4f990dd795b8efd7ffcb0d9120a9515cf530c3ff1d::eksarpi {
    struct EKSARPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKSARPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKSARPI>(arg0, 9, b"EKSARPI", b"EKS-AR-PI", b"EKS-AR-PI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/d822dda96ee51685037e54c748a4f7c2af50bafa1ab9b8290dd11c606bd3d129?r=3&w=128")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<EKSARPI>>(0x2::coin::mint<EKSARPI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EKSARPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKSARPI>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

