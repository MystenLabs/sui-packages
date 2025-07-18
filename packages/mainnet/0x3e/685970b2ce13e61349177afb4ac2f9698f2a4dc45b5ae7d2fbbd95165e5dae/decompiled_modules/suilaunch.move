module 0x3e685970b2ce13e61349177afb4ac2f9698f2a4dc45b5ae7d2fbbd95165e5dae::suilaunch {
    struct SUILAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUILAUNCH>(arg0, 6, b"SUILAUNCH", b"SuiLaunch", b"Launch a project on @SuiAIFun by tagging @suilaunchcoin and including the project name and logo. For example: @suilaunchcoin $SUILAUNCH + SuiLaunch https://t.co/dZlR1MBpZn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GwHCWGlXgAEZAkC.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILAUNCH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAUNCH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

