module 0xa145427342affbedfa9cdfeba34f98d33bfb13e329ab6adca193f66225a12be4::LegbaPinkEars {
    struct LEGBAPINKEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGBAPINKEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGBAPINKEARS>(arg0, 0, b"COS", b"Legba Pink Ears", b"And the Devouring comes for all of us...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Legba_Pink_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGBAPINKEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGBAPINKEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

