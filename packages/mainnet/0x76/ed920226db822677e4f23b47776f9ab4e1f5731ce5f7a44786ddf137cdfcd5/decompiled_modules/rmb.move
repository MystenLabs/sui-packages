module 0x76ed920226db822677e4f23b47776f9ab4e1f5731ce5f7a44786ddf137cdfcd5::rmb {
    struct RMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMB>(arg0, 8, b"rmb", b"rmb", b"this is a rmb coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMB>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RMB>>(v0);
    }

    // decompiled from Move bytecode v6
}

