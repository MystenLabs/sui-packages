module 0xc4d388512c003224378c1cee5d238f0948b8b2ac485abd8b2cea3b93e28e1133::GreedclungSeraphWings {
    struct GREEDCLUNGSERAPHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEDCLUNGSERAPHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEDCLUNGSERAPHWINGS>(arg0, 0, b"COS", b"Greedclung Seraph Wings", b"Consuming... ecstatic... the wolves have circled...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Greedclung_Seraph_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEDCLUNGSERAPHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEDCLUNGSERAPHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

