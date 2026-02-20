module 0xe50dfa9fa0d0e79e40c685f4ea7b0d529396e500b3b968ee303748d3e44540d6::status_coin {
    struct STATUS_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STATUS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STATUS_COIN>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STATUS_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STATUS_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

