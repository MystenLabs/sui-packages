module 0x37f31bac935a8a4e3174bbe4a7bc22dfa995b1396b5481d0b29ec8e9cb0a728f::AJollyEnsemble {
    struct AJOLLYENSEMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AJOLLYENSEMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJOLLYENSEMBLE>(arg0, 0, b"COS", b"A Jolly Ensemble", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Jolly_Ensemble.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJOLLYENSEMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJOLLYENSEMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

