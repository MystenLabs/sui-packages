module 0x476b3faa18750b8a756026c66d1c6bde6ef8648066b8479688ed0a5be827fd25::EleriahsSpiritWings {
    struct ELERIAHSSPIRITWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELERIAHSSPIRITWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELERIAHSSPIRITWINGS>(arg0, 0, b"COS", b"Eleriah's Spirit Wings", b"Untrammeled... Undefeated... A sun brings life from the ground...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Eleriah's_Spirit_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELERIAHSSPIRITWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELERIAHSSPIRITWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

