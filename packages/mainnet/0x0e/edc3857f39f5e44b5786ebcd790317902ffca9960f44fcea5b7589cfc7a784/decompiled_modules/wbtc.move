module 0xeedc3857f39f5e44b5786ebcd790317902ffca9960f44fcea5b7589cfc7a784::wbtc {
    struct WBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC>(arg0, 9, b"WBTC", b"Wrapped BTC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

