module 0xefe8b8a0e62425ee287e2a6c38fa5a20d44d5041be8b77d6846960d69e4e8bb5::cozcat {
    struct COZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COZCAT>(arg0, 6, b"COZCAT", b"Cozcat", b"In other words, we don't know where $COZCAT went.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_cozcat_3d149c4f59.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

