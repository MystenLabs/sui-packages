module 0x9ffd4c1f1dbb5e318add14108b4846149a6c53972bd3c1ca9cd3ff9bb15a305a::fishman {
    struct FISHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMAN>(arg0, 9, b"FISHMAN", b"Fishman on Sui", x"4920666f756e64206d79206c616e64202353554920f09f8c8af09f8c8a207c20576562736974653a2068747470733a2f2f782e636f6d2f466973686d616e535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/ELspOd7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

