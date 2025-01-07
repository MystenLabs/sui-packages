module 0xe86f7b2683f9601b449c78630f55a9093e711e16d66fb5528e0b1796c9e845aa::SashoftheOpyaan {
    struct SASHOFTHEOPYAAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHEOPYAAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHEOPYAAN>(arg0, 0, b"COS", b"Sash of the Opyaan", b"Left behind on the lighthouse steps...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Opyaan.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHEOPYAAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHEOPYAAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

