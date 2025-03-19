module 0x66f2e0ccf81da4bdf48f6e65728b04ab5b2356571d0a524e3c830e28ffc4e527::ingmar {
    struct INGMAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: INGMAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INGMAR>(arg0, 8, b"ING", b"ING", b"For great Ingmar Bergman, love your movies!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INGMAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INGMAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

