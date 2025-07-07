module 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::usdz {
    struct USDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDZ>(arg0, 6, b"USDZ", b"USDZ", b"Yield-bearing stable LP Token for ZO Perpetuals Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://img.zofinance.io/usdz.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDZ>>(v1);
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::market::create_market<USDZ>(0x2::coin::treasury_into_supply<USDZ>(v0), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

