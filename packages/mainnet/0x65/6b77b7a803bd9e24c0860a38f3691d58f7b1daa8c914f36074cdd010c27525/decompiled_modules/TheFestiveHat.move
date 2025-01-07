module 0x656b77b7a803bd9e24c0860a38f3691d58f7b1daa8c914f36074cdd010c27525::TheFestiveHat {
    struct THEFESTIVEHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEFESTIVEHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEFESTIVEHAT>(arg0, 0, b"COS", b"The Festive Hat", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_The_Festive_Hat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEFESTIVEHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEFESTIVEHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

