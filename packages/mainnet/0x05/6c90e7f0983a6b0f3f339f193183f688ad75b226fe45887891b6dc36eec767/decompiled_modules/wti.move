module 0x56c90e7f0983a6b0f3f339f193183f688ad75b226fe45887891b6dc36eec767::wti {
    struct WTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTI>(arg0, 9, b"WTI", b"WTI Crude Oil", b"ZO Virtual Coin for WTI Crude Oil (West Texas Intermediate)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WTI>>(v0);
    }

    // decompiled from Move bytecode v6
}

