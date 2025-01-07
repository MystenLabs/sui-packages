module 0x9cf1ab606e38c0f0d840ad797663444bb14a989af6b111092a1b687433eba9c6::HearthGemReader {
    struct HEARTHGEMREADER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEARTHGEMREADER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEARTHGEMREADER>(arg0, 0, b"COS", b"Hearth GemReader", b"The most valuable rocks are the ones yet seen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Hearth_GemReader.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEARTHGEMREADER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEARTHGEMREADER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

