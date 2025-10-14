module 0xdde903d967d7170b2f046c78d9da5a2ae7dfdfe67dc1f450748b0545b9e56e46::ttt_coin {
    struct TTT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT_COIN>(arg0, 9, b"TTT", b"ttt", b"ttt", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTT_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

