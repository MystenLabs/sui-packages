module 0x8e04255c99e4b73b7fc457ea21c21faba19f1b54ce366e7f893d9bbe1a4e0b2f::WayfarersKnots {
    struct WAYFARERSKNOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAYFARERSKNOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAYFARERSKNOTS>(arg0, 0, b"COS", b"Wayfarer's Knots", b"Footsteps... nearby... do you hear them? The Hunters?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Wayfarer's_Knots.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAYFARERSKNOTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAYFARERSKNOTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

