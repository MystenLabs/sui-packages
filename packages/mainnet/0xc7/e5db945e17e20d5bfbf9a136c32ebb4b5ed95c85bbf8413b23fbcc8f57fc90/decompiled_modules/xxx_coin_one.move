module 0xc7e5db945e17e20d5bfbf9a136c32ebb4b5ed95c85bbf8413b23fbcc8f57fc90::xxx_coin_one {
    struct XXX_COIN_ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX_COIN_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX_COIN_ONE>(arg0, 9, b"MePeHe", b"hehe Token", b"meme test no funding", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XXX_COIN_ONE>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XXX_COIN_ONE>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<XXX_COIN_ONE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XXX_COIN_ONE>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

