module 0xd3f59ea8219d242daae8a76b1c1183aac5abc8bc03da314184a6b455f5cd5c31::btc_perp {
    struct BTC_PERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC_PERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC_PERP>(arg0, 8, b"BTC_PERP", b"BTC_PERP", b"real btc", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC_PERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC_PERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

