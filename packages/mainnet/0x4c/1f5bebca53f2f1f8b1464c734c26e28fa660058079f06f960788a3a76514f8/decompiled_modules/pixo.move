module 0x4c1f5bebca53f2f1f8b1464c734c26e28fa660058079f06f960788a3a76514f8::pixo {
    struct PIXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXO>(arg0, 6, b"PIXO", b"PIXO WORLD", b"PIXO WORLD GAMEPLAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiakgb4aktnul7diq2pw2bfuujsewqfwakreag7sxj6crzeqgnzuny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIXO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

