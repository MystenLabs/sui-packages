module 0x5dd23a351b8e1651ecbea669ca1c5760b37bd699ba48f8b6f9355b27a15cf824::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg0, 10000000, arg2), arg1);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 6, b"MY_COIN_yellow", b"Dr_yellow coin", b"first erc20 coint", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

