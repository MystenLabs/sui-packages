module 0x8269478490c94cf2d74288ee11be8f0588998254e75f1cd44e9a65670dc88c7e::xau {
    struct XAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAU>(arg0, 9, b"XAU", b"XAU", b"ZO Virtual Coin for XAU (Gold)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XAU>>(v0);
    }

    // decompiled from Move bytecode v6
}

