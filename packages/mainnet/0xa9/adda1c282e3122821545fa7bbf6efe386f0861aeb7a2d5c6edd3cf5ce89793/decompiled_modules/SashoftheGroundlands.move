module 0xa9adda1c282e3122821545fa7bbf6efe386f0861aeb7a2d5c6edd3cf5ce89793::SashoftheGroundlands {
    struct SASHOFTHEGROUNDLANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHEGROUNDLANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHEGROUNDLANDS>(arg0, 0, b"COS", b"Sash of the Groundlands", b"Left behind in the roots of a tree...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Groundlands.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHEGROUNDLANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHEGROUNDLANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

