module 0x5dc56ca671574a632ba758706545a12c5a95790b951d85f3de05c9faf6232da::GroundListeningEars {
    struct GROUNDLISTENINGEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROUNDLISTENINGEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROUNDLISTENINGEARS>(arg0, 0, b"COS", b"GroundListening Ears", b"The ElderRoots whisper and bend... fables of fields and footprints...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_GroundListening_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROUNDLISTENINGEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROUNDLISTENINGEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

