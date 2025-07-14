module 0xdea3242157ba180e781f668c723a9bb3a83189c03d2d1038af5a140d199e052c::mystemon_coin {
    struct MYSTEMON_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTEMON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTEMON_COIN>(arg0, 9, b"MYSTEMON", b"Mystemon Coin", b"A coin for Mystemon", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTEMON_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYSTEMON_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

