module 0x46872d0c5784717cf24740528d62737e1bd8f4a6ac6f5fc12fcdb9fc4a56e325::special_coin {
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

