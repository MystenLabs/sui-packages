module 0x43e7a6b4dd7daee8957d9bdfe2c804b9608aa20125b63423a188f54f41e472f7::troop {
    struct TROOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROOP>(arg0, 6, b"Troop", b"Troop Sui", x"54726f6f702041726d79206f6e207375690a68747470733a2f2f7777772e636f696e6765636b6f2e636f6d2f656e2f636f696e732f74726f6f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_6b118dd6a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

