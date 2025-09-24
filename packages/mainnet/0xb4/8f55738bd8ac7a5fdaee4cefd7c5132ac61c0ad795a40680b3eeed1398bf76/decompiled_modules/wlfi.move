module 0xb48f55738bd8ac7a5fdaee4cefd7c5132ac61c0ad795a40680b3eeed1398bf76::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 9, b"WLFI", b"World Liberty Financial", b"ZO Virtual Coin for World Liberty Financial", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLFI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WLFI>>(v0);
    }

    // decompiled from Move bytecode v6
}

