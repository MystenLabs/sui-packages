module 0xf33daae626ceca9572b7ad2f40372da271f1bb9633d29f0af648046f48c2923f::my_move_coin {
    struct MY_MOVE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_MOVE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_MOVE_COIN>(arg0, 6, b"MCN", b"My move coin", b"first step in sui move", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_MOVE_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_MOVE_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

