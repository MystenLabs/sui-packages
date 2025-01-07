module 0x88894acbeb5e6b0eb187cfb6af7b56af7d128eb12ea2a110078b7992b90e538c::ARejoicefulEnsemble {
    struct AREJOICEFULENSEMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AREJOICEFULENSEMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AREJOICEFULENSEMBLE>(arg0, 0, b"COS", b"A Rejoiceful Ensemble", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Rejoiceful_Ensemble.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AREJOICEFULENSEMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AREJOICEFULENSEMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

