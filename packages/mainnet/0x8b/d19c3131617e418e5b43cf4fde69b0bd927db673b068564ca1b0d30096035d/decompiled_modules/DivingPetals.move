module 0x8bd19c3131617e418e5b43cf4fde69b0bd927db673b068564ca1b0d30096035d::DivingPetals {
    struct DIVINGPETALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVINGPETALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVINGPETALS>(arg0, 0, b"COS", b"Diving Petals", b"Sky, swooned heavens, eclipsed... hope, seized...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Diving_Petals.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVINGPETALS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVINGPETALS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

