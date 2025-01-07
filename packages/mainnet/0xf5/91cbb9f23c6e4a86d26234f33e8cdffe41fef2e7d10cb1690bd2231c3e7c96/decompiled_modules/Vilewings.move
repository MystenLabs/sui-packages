module 0xf591cbb9f23c6e4a86d26234f33e8cdffe41fef2e7d10cb1690bd2231c3e7c96::Vilewings {
    struct VILEWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VILEWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VILEWINGS>(arg0, 0, b"COS", b"Vilewings", b"Saintly, not disgusting... fearful, not feared...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Vilewings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VILEWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VILEWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

