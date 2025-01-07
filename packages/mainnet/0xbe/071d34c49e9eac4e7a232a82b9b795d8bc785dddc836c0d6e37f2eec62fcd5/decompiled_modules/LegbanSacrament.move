module 0xbe071d34c49e9eac4e7a232a82b9b795d8bc785dddc836c0d6e37f2eec62fcd5::LegbanSacrament {
    struct LEGBANSACRAMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGBANSACRAMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGBANSACRAMENT>(arg0, 0, b"COS", b"Legban Sacrament", b"This is home now; forget not your past elder-world...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Legban_Sacrament.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGBANSACRAMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGBANSACRAMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

