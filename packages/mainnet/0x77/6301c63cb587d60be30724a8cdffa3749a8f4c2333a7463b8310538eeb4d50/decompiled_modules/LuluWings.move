module 0x776301c63cb587d60be30724a8cdffa3749a8f4c2333a7463b8310538eeb4d50::LuluWings {
    struct LULUWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULUWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LULUWINGS>(arg0, 0, b"COS", b"LuluWings", b"Be careful, little one... Don't fly too far from home...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_LuluWings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LULUWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULUWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

