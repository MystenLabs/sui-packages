module 0xe3fff117d1b7ee95142c0e303ef4cace3c3b192b92f8e699ad5446a2e8eafe0b::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JOY>(arg0, 6, b"JOY", b"JOY", b"Joy is a positive emotion characterized by feelings of happiness, delight, and contentment, often arising from meaningful experiences, achievements, or connections with others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/90446660_ced7_44de_b6e6_2456c1f383e8_1_086986980c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

