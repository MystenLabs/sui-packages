module 0xee38ee5886ac7426ff746768b8e93a6b95be1d28618b109f93918206ba7046e8::ACelebratoryEnsemble {
    struct ACELEBRATORYENSEMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACELEBRATORYENSEMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACELEBRATORYENSEMBLE>(arg0, 0, b"COS", b"A Celebratory Ensemble", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Celebratory_Ensemble.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACELEBRATORYENSEMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACELEBRATORYENSEMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

