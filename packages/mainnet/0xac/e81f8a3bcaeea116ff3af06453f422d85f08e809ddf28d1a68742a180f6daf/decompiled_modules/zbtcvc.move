module 0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::zbtcvc {
    struct ZBTCVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZBTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<ZBTCVC>(arg0, 8, b"zBTCvc", b"zBTCvc", b"Yield Bearing BTC-LP Token for Custodial Vishwa BTC issued by ZO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://img.zofinance.io/zbtcvc.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZBTCVC>>(v1);
        0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::market::create_market<ZBTCVC>(0x2::coin::treasury_into_supply<ZBTCVC>(v0), 0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

