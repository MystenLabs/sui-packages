module 0x9d0d19e2dc743addec139d5e436763184fbdb42dc5d573376d65783b3addc2db::ACheeryEnsemble {
    struct ACHEERYENSEMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACHEERYENSEMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACHEERYENSEMBLE>(arg0, 0, b"COS", b"A Cheery Ensemble", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Cheery_Ensemble.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACHEERYENSEMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACHEERYENSEMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

