module 0x5a082bd72d0e2f87b344a8870ee7d48e8e5fbf2f5772194a5d292ff27a37e0fe::SashoftheFey {
    struct SASHOFTHEFEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHEFEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHEFEY>(arg0, 0, b"COS", b"Sash of the Fey", b"Left behind on a tangled branch...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Fey.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHEFEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHEFEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

