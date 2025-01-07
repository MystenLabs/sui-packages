module 0x8592d41b28815030c40cae43bf30a3f75657e57e6028a05c1b56e5f236b1416e::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 6, b"XRP", b"Wrapped Coin for Ripple", b"Sudo Wrapped Coin for Ripple", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XRP>>(v0);
    }

    // decompiled from Move bytecode v6
}

