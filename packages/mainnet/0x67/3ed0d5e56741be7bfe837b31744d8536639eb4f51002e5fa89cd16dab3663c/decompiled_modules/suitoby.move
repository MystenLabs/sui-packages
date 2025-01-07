module 0x673ed0d5e56741be7bfe837b31744d8536639eb4f51002e5fa89cd16dab3663c::suitoby {
    struct SUITOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOBY>(arg0, 6, b"SUITOBY", b"TOBY", x"24544f42592069732073696d706c792061204d656d65636f696e2053554920657869737420666f722066756e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3518_9a95e708df.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

