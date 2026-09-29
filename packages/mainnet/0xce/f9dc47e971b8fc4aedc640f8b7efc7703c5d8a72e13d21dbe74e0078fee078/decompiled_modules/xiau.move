module 0xcef9dc47e971b8fc4aedc640f8b7efc7703c5d8a72e13d21dbe74e0078fee078::xiau {
    struct XIAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAU>(arg0, 9, b"XIAU", b"XiAu", b"XiAu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/c3daa42ea60cbc38de53cf481437d41a2aa6e2f91a3e3376634483935f9256cf")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<XIAU>>(0x2::coin::mint<XIAU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIAU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAU>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

