module 0x877241d2c331ca7f6103cbd2cb5907b78aa7ac785be5a5a0effc83c9499b1527::ChantoftheCelebrants {
    struct CHANTOFTHECELEBRANTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHANTOFTHECELEBRANTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANTOFTHECELEBRANTS>(arg0, 0, b"COS", b"Chant of the Celebrants", b"Heed their words... reach... for the sacred beyond...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Chant_of_the_Celebrants.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHANTOFTHECELEBRANTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANTOFTHECELEBRANTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

