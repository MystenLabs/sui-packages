module 0x60fc29a6141aa944d953cc57d97396d898d558d94dc939610cd6166a10a38646::dogo {
    struct DOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGO>(arg0, 9, b"DOGO", b"Dogo Coin", b"The Dogo coin in sui network", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

