module 0x2c7e2b5e12c5e4c6518b79b61d3e10613277b107dd90c8894f75caf28e557add::VisitationGrandeur {
    struct VISITATIONGRANDEUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VISITATIONGRANDEUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VISITATIONGRANDEUR>(arg0, 0, b"COS", b"Visitation Grandeur", b"A voice calls... and echoes as you cross the precipice of paradise... It says...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Visitation_Grandeur.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VISITATIONGRANDEUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISITATIONGRANDEUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

