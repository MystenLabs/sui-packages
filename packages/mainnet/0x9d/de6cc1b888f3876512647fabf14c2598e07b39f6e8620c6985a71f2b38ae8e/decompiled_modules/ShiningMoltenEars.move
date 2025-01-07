module 0x9dde6cc1b888f3876512647fabf14c2598e07b39f6e8620c6985a71f2b38ae8e::ShiningMoltenEars {
    struct SHININGMOLTENEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHININGMOLTENEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHININGMOLTENEARS>(arg0, 0, b"COS", b"Shining Molten Ears", b"Here, all are welcome-even at their most peculiar...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Shining_Molten_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHININGMOLTENEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHININGMOLTENEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

