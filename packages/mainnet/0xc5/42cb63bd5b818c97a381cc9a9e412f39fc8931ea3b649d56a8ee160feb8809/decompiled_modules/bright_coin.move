module 0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin {
    struct BRIGHT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIGHT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIGHT_COIN>(arg0, 6, b"Bright", b"bright coin", b"My_token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRIGHT_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIGHT_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<BRIGHT_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRIGHT_COIN>>(0x2::coin::mint<BRIGHT_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

