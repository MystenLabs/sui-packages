module 0xd70dfae93907b37f3005834f2679a4e660eab5b28a05b35f78468d30f2710861::suilaunch {
    struct SUILAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAUNCH>(arg0, 6, b"SUILAUNCH", b"SuiLaunch", b"Launch a project on @SuiAIFun by tagging @suilaunchcoin and including the project name and logo. For example: @suilaunchcoin $SUILAUNCH + SuiLaunch https://t.co/dZlR1MBpZn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752925065109.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILAUNCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAUNCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

