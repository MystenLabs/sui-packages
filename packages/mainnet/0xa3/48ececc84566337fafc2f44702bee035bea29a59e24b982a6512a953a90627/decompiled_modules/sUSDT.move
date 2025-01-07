module 0xa348ececc84566337fafc2f44702bee035bea29a59e24b982a6512a953a90627::sUSDT {
    struct SUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDT>(arg0, 9, b"sysUSDT", b"SY sUSDT", b"SY scallop sUSDT", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

