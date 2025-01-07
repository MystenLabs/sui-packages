module 0x7b88cdbe76cb0d03cad851cc860ca7388df9f6925139cadb19aace5a0379bc84::HearthYellow {
    struct HEARTHYELLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEARTHYELLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEARTHYELLOW>(arg0, 0, b"COS", b"Hearth Yellow", b"What a prize, this spirit novelty!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Hearth_Yellow.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEARTHYELLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEARTHYELLOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

