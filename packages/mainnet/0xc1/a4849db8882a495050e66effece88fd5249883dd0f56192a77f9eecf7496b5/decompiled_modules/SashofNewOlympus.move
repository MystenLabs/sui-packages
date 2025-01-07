module 0xc1a4849db8882a495050e66effece88fd5249883dd0f56192a77f9eecf7496b5::SashofNewOlympus {
    struct SASHOFNEWOLYMPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFNEWOLYMPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFNEWOLYMPUS>(arg0, 0, b"COS", b"Sash of New Olympus", b"Left behind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_New_Olympus.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFNEWOLYMPUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFNEWOLYMPUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

