module 0x44b2697150c1b908b03e5bc29f3aa9ac705ce98b3b0a46326f9e7986e40deab2::SashoftheSands {
    struct SASHOFTHESANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHESANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHESANDS>(arg0, 0, b"COS", b"Sash of the Sands", b"Left behind on a sandy cliff...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Sands.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHESANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHESANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

