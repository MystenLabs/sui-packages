module 0x89ab0e3b699d11eb47c8a1efe43290dde23fa083aacafa6ade9486fb112fd966::soh {
    struct SOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOH>(arg0, 9, b"SOH", b"Strait of Hormuz", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/82293cc9c8bf41a7393a4c87705354fb69f26aac248f95cfd7b8d6f7df7b972e")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SOH>>(0x2::coin::mint<SOH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOH>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

