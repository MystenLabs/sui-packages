module 0xe05da9fb13916ad7fab15c204abc356bc16bef1c4169222d83298b5c2cc7dab3::AHolidayEnsemble {
    struct AHOLIDAYENSEMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHOLIDAYENSEMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHOLIDAYENSEMBLE>(arg0, 0, b"COS", b"A Holiday Ensemble", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Holiday_Ensemble.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHOLIDAYENSEMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHOLIDAYENSEMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

