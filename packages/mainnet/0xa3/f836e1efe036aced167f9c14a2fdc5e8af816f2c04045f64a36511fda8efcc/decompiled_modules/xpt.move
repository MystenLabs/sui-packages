module 0xa3f836e1efe036aced167f9c14a2fdc5e8af816f2c04045f64a36511fda8efcc::xpt {
    struct XPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPT>(arg0, 9, b"XPT", b"XPT", b"ZO Virtual Coin for XPT (Platinum)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XPT>>(v0);
    }

    // decompiled from Move bytecode v6
}

