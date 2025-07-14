module 0x3ba5e023a32a197be2a0a7cf3c9fbea58af585655d1cbd1c39f2bbe8888f9d0c::wbtc {
    struct WBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC>(arg0, 6, b"WBTC", b"Wrapped BTC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

