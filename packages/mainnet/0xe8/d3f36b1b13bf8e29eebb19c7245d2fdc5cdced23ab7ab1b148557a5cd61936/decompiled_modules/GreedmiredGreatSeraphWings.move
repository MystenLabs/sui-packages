module 0xe8d3f36b1b13bf8e29eebb19c7245d2fdc5cdced23ab7ab1b148557a5cd61936::GreedmiredGreatSeraphWings {
    struct GREEDMIREDGREATSERAPHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEDMIREDGREATSERAPHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEDMIREDGREATSERAPHWINGS>(arg0, 0, b"COS", b"Greedmired Great Seraph Wings", b"Aurah... tarnished...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Greedmired_Great_Seraph_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEDMIREDGREATSERAPHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEDMIREDGREATSERAPHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

