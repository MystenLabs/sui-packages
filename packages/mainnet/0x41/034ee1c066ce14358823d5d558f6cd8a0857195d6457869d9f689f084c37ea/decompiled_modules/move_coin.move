module 0x41034ee1c066ce14358823d5d558f6cd8a0857195d6457869d9f689f084c37ea::move_coin {
    struct MOVE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE_COIN>(arg0, 2, b"MyCoin", b"MYC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOVE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVE_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOVE_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

