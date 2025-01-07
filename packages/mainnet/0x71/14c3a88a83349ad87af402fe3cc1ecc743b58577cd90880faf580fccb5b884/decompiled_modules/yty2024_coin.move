module 0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin {
    struct YTY2024_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTY2024_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTY2024_COIN>(arg0, 6, b"yty2024_coin", b"yty2024 coin name", b"yty2024 coin description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YTY2024_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YTY2024_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YTY2024_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YTY2024_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

