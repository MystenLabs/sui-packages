module 0x9287f087d38b4d5d11748580c2d98aae04ea80a9fe75c6836721a36eb360b461::rmb {
    struct RMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMB>(arg0, 8, b"RMB", b"RMB", b"this id a RMB", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMB>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RMB>>(v0);
    }

    // decompiled from Move bytecode v6
}

