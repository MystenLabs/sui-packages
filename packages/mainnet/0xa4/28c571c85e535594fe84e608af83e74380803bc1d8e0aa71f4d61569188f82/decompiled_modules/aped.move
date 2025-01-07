module 0xa428c571c85e535594fe84e608af83e74380803bc1d8e0aa71f4d61569188f82::aped {
    struct APED has drop {
        dummy_field: bool,
    }

    fun init(arg0: APED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APED>(arg0, 6, b"APED", b"Aped Sui", x"43796d62616c2d636c617070696e672c2062616e616e612d63686f6d70696e672c2063727970746f206e696768746d617265207772617070656420696e206a6f6c6c79206d6f6e6b6579206368616f73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_new_1_6c2cbd5da4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APED>>(v1);
    }

    // decompiled from Move bytecode v6
}

