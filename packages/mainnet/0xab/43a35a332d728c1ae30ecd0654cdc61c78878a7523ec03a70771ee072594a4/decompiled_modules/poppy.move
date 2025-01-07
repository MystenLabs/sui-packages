module 0xab43a35a332d728c1ae30ecd0654cdc61c78878a7523ec03a70771ee072594a4::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 6, b"POPPY", b"SUI POPPY", x"504f50505920546865206d6f73742061646f7261626c6520736561206c696f6e20696e2063727970746f2c206d616b696e6720776176657320696e2074686520535549206f6365616e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23_edef315767.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

