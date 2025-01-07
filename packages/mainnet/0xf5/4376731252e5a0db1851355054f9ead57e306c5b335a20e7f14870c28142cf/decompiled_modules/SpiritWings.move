module 0xf54376731252e5a0db1851355054f9ead57e306c5b335a20e7f14870c28142cf::SpiritWings {
    struct SPIRITWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIRITWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIRITWINGS>(arg0, 0, b"COS", b"Spirit Wings", b"Because Eluune sees you. Because Eluune sees all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Spirit_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPIRITWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIRITWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

