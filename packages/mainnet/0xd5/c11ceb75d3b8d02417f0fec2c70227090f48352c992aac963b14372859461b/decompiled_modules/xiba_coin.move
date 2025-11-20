module 0xd5c11ceb75d3b8d02417f0fec2c70227090f48352c992aac963b14372859461b::xiba_coin {
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

