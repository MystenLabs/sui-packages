module 0xc35ffe7245a5ddc02319730c636676659f52f025da057962e4ea78a5321e75fd::xuat {
    struct XUAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUAT>(arg0, 9, b"XUAT", x"e9bb84e98791e7a8b3e5ae9ae5b881", b"Template Coin Description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XUAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

