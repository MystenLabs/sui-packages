module 0xccbe4fc9549fecb59e63a74eb8b2d399e55cfa4b727cae83ebc81dc34b828919::AMerryEnsemble {
    struct AMERRYENSEMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMERRYENSEMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMERRYENSEMBLE>(arg0, 0, b"COS", b"A Merry Ensemble", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Merry_Ensemble.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMERRYENSEMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMERRYENSEMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

