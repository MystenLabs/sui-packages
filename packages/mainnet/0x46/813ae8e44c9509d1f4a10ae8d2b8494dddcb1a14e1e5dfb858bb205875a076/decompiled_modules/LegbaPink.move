module 0x46813ae8e44c9509d1f4a10ae8d2b8494dddcb1a14e1e5dfb858bb205875a076::LegbaPink {
    struct LEGBAPINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGBAPINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGBAPINK>(arg0, 0, b"COS", b"Legba Pink", b"No names exist for you... yet you persist, regardless...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Legba_Pink.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGBAPINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGBAPINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

