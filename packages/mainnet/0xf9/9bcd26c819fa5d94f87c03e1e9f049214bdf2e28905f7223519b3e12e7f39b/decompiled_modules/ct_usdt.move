module 0xf99bcd26c819fa5d94f87c03e1e9f049214bdf2e28905f7223519b3e12e7f39b::ct_usdt {
    struct CT_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT_USDT>(arg0, 6, b"ctUSDT", b"Centaurus Wrapped Token for Eth Brideged Usdt.", b"Centaurus Wrapped Token for Eth Brideged Usdt.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CT_USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT_USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

