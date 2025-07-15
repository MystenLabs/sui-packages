module 0x883f55dccaf24891ef041489d4bd25f072a5d795071b9450874655b3ab1ca3b9::mystemon_coin {
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

