module 0x1fb2d461124f6120f7da57f77ada6deefed1dd3e7a6a829f5d29c5d963327bdf::HavensGreen {
    struct HAVENSGREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAVENSGREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAVENSGREEN>(arg0, 0, b"COS", b"Havens Green", b"Captured in the dwindled forest light...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Havens_Green.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAVENSGREEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAVENSGREEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

