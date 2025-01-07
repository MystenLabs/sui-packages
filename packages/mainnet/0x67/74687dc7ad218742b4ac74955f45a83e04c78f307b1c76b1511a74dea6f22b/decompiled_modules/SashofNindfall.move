module 0x6774687dc7ad218742b4ac74955f45a83e04c78f307b1c76b1511a74dea6f22b::SashofNindfall {
    struct SASHOFNINDFALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFNINDFALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFNINDFALL>(arg0, 0, b"COS", b"Sash of Nindfall", b"Left behind on a screaming husk...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_Nindfall.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFNINDFALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFNINDFALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

