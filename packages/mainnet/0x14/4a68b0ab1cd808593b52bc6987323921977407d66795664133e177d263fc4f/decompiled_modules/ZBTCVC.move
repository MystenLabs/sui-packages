module 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::ZBTCVC {
    struct ZBTCVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZBTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<ZBTCVC>(arg0, 8, b"zBTCvc", b"zBTCvc", b"Yield Bearing BTC-LP Token for Custodial Vishwa BTC issued by ZO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://img.zofinance.io/zbtcvc.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZBTCVC>>(v1);
        0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::market::create_market<ZBTCVC>(0x2::coin::treasury_into_supply<ZBTCVC>(v0), 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

