module 0xd8e9a147f3eaecc16a9a7eb0f6f987e4f30841b0e8b19b55afe84afa6e1d8a18::DesertListeningMushrooms {
    struct DESERTLISTENINGMUSHROOMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESERTLISTENINGMUSHROOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESERTLISTENINGMUSHROOMS>(arg0, 0, b"COS", b"Desert Listening Mushrooms", b"Little one, close your hands upon your ears... the ocean calls...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Desert_Listening_Mushrooms.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DESERTLISTENINGMUSHROOMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESERTLISTENINGMUSHROOMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

