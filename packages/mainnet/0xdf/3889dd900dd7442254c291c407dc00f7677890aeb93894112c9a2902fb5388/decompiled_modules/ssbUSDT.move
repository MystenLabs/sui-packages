module 0xdf3889dd900dd7442254c291c407dc00f7677890aeb93894112c9a2902fb5388::ssbUSDT {
    struct SSBUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSBUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSBUSDT>(arg0, 6, b"sysSBUSDT", b"SY sSBUSDT", b"SY scallop sSBUSDT", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSBUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSBUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

