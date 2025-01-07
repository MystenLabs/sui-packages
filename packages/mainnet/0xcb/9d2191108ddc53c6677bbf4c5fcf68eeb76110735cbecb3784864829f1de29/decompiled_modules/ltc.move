module 0xcb9d2191108ddc53c6677bbf4c5fcf68eeb76110735cbecb3784864829f1de29::ltc {
    struct LTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTC>(arg0, 8, b"LTC", b"Wrapped Litecoin", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LTC>>(v0);
    }

    // decompiled from Move bytecode v6
}

