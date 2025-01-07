module 0x40f7e6b2ba4b4ded078150dc614c91d90629155bbc4079d6112854b575ede018::CoralienCrownofSB {
    struct CORALIENCROWNOFSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORALIENCROWNOFSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORALIENCROWNOFSB>(arg0, 0, b"COS", b"Coralien Crown of SB", b"Be king. Rule the distance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Coralien_Crown_of_SB.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORALIENCROWNOFSB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORALIENCROWNOFSB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

