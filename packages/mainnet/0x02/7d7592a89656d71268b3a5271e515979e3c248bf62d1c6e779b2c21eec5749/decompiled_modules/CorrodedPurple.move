module 0x27d7592a89656d71268b3a5271e515979e3c248bf62d1c6e779b2c21eec5749::CorrodedPurple {
    struct CORRODEDPURPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORRODEDPURPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORRODEDPURPLE>(arg0, 0, b"COS", b"Corroded Purple", b"Tinged with corrosion... the gleam of nightmares...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Corroded_Purple.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORRODEDPURPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORRODEDPURPLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

