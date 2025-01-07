module 0xced2ba878a100bb40605c516e9a34c757508722b1cd6829789cbc04bb0669658::jamma {
    struct JAMMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMMA>(arg0, 6, b"JAMMA", b"JammaApe", b"Just a Jamma Ape, fair launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735137100414.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAMMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

