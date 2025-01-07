module 0x57a673eb38b1086f8a2610e7fbb14b221761bb5f2835e07933beef01b35e9ccc::GreedmiredSeraphWings {
    struct GREEDMIREDSERAPHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEDMIREDSERAPHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEDMIREDSERAPHWINGS>(arg0, 0, b"COS", b"Greedmired Seraph Wings", b"Winged one, why have you turned your back on me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Greedmired_Seraph_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEDMIREDSERAPHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEDMIREDSERAPHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

