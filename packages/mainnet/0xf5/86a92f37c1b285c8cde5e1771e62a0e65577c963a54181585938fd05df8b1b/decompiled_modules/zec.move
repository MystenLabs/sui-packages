module 0xf586a92f37c1b285c8cde5e1771e62a0e65577c963a54181585938fd05df8b1b::zec {
    struct ZEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEC>(arg0, 8, b"ZEC", b"Wrapped ZEC", b"ZO Finance Virtual Coin for ZEC (Zcash)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZEC>>(v0);
    }

    // decompiled from Move bytecode v7
}

