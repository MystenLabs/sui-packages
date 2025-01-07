module 0x915badef1ea6a3603ed6c599d3c224c9183302df6f50b9cf02fdf2546258c48d::AncientFrost {
    struct ANCIENTFROST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCIENTFROST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCIENTFROST>(arg0, 0, b"COS", b"Ancient Frost", b"Endure the cold, lest it endure itself...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Ancient_Frost.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANCIENTFROST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCIENTFROST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

