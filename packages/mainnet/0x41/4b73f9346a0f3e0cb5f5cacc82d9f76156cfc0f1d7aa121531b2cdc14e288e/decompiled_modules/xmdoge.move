module 0x414b73f9346a0f3e0cb5f5cacc82d9f76156cfc0f1d7aa121531b2cdc14e288e::xmdoge {
    struct XMDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMDOGE>(arg0, 6, b"XMDOGE", b"XMDOGE on SUI", b"XMDOGE on Christmas day!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/40b_X_rfv_400x400_5dbacb212b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

