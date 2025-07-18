module 0xcb1315c43d11478e1ac1e28b039e11c38a72d76aac9827af6614a765e887cc4c::suilaunch {
    struct SUILAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUILAUNCH>(arg0, 6, b"SUILAUNCH", b"SuiLaunch", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $SUILAUNCH+SuiLaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suilaunch-1xj5b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILAUNCH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAUNCH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

