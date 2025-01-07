module 0xf2cea4b07b92d4c2b7a9de6684f2db8434dd875cbd7bd531c7d8928688122dc7::TranscendentWings {
    struct TRANSCENDENTWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRANSCENDENTWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRANSCENDENTWINGS>(arg0, 0, b"COS", b"Transcendent Wings", b"Gliding over the landscape... over Fallen Eleriah...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Transcendent_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRANSCENDENTWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRANSCENDENTWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

