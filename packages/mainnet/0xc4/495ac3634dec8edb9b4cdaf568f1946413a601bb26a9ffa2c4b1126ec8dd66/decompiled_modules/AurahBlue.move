module 0xc4495ac3634dec8edb9b4cdaf568f1946413a601bb26a9ffa2c4b1126ec8dd66::AurahBlue {
    struct AURAHBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAHBLUE>(arg0, 0, b"COS", b"AurahBlue", b"Like all journeys in the unknown... you have found yourself...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_AurahBlue.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURAHBLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAHBLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

