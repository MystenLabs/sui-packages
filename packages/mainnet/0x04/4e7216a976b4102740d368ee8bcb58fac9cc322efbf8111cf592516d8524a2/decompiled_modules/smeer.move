module 0x44e7216a976b4102740d368ee8bcb58fac9cc322efbf8111cf592516d8524a2::smeer {
    struct SMEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEER>(arg0, 6, b"SMEER", b"SassyMeerkat", b"Where Cool Meets Cute - Join the Meerkat Craze!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_16_41_49_6d0dbb8082.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

