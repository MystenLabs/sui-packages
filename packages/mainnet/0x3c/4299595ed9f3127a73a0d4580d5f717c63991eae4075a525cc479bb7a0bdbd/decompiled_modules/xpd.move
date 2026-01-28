module 0x3c4299595ed9f3127a73a0d4580d5f717c63991eae4075a525cc479bb7a0bdbd::xpd {
    struct XPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPD>(arg0, 9, b"XPD", b"XPD", b"ZO Virtual Coin for XPD (Palladium)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XPD>>(v0);
    }

    // decompiled from Move bytecode v6
}

