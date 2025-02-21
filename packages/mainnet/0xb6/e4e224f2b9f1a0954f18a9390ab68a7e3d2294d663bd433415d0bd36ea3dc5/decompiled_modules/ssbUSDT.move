module 0xb6e4e224f2b9f1a0954f18a9390ab68a7e3d2294d663bd433415d0bd36ea3dc5::ssbUSDT {
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

