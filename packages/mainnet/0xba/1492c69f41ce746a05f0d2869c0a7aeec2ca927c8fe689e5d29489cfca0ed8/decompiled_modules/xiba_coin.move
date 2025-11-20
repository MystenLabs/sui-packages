module 0xba1492c69f41ce746a05f0d2869c0a7aeec2ca927c8fe689e5d29489cfca0ed8::xiba_coin {
    struct XIBA_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIBA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIBA_COIN>(arg0, 6, b"XIBA", b"XiBa Coin", b"XiBa Coin is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIBA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIBA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

