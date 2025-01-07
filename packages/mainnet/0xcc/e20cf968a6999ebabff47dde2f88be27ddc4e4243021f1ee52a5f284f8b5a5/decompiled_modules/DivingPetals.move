module 0xcce20cf968a6999ebabff47dde2f88be27ddc4e4243021f1ee52a5f284f8b5a5::DivingPetals {
    struct DIVINGPETALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVINGPETALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVINGPETALS>(arg0, 0, b"PACK", b"Diving Petals", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Diving_Petals.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVINGPETALS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVINGPETALS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

