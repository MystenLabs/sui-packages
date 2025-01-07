module 0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin {
    struct YTY2024_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YTY2024_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YTY2024_FAUCET_COIN>>(0x2::coin::mint<YTY2024_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YTY2024_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTY2024_FAUCET_COIN>(arg0, 6, b"yty2024_faucet_coin", b"yty2024_faucet_coin name", b"yty2024_faucet_coin description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YTY2024_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YTY2024_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

