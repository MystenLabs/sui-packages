module 0x708c4957ff3e11e1bb09428fd843b944208d1c900e4ab8d42381d0c407477e1b::mystemon_coin {
    struct MYSTEMON_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTEMON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTEMON_COIN>(arg0, 6, b"MSTMN", b"Mystemon Coin", b"A coin for the Mystemon project.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYSTEMON_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTEMON_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

