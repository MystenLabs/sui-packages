module 0x170bb0a23bd074e1ea9f1c9d3c6974bc7856f4a7284c5c13f124484406e3f3e4::special_coin {
    struct SPECIAL_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPECIAL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPECIAL_COIN>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPECIAL_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPECIAL_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

