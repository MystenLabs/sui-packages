module 0x5b3b41fafc8d61b97ee6592c78cee82b2e7764752fb79e9497bae2e09bc1a25d::rmb {
    struct RMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMB>(arg0, 8, b"RMB", b"RMB", b"this is rmb", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMB>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RMB>>(v0);
    }

    // decompiled from Move bytecode v6
}

