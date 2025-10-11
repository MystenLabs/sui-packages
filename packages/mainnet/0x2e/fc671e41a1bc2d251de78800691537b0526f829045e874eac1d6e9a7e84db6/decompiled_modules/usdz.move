module 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::usdz {
    struct USDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<USDZ>(arg0, 6, b"USDZ", b"USDZ", b"Yield-bearing stable LP Token for ZO Perpetuals Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://img.zofinance.io/usdz.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDZ>>(v1);
        0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::market::create_market<USDZ>(0x2::coin::treasury_into_supply<USDZ>(v0), 0x7fd8aba1652c58b6397c799fd375e748e5053145cb7e126d303e0a1545fd1fec::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

