module 0x5e1add9540587b617e9d37c6dd7f15e92daffe4d099f7108c8642454815128af::star_coin_coin {
    struct STAR_COIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR_COIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR_COIN_COIN>(arg0, 6, b"STAR", b"star coin", b"Fixed-supply coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<STAR_COIN_COIN>>(0x2::coin::mint<STAR_COIN_COIN>(&mut v2, 500000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAR_COIN_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STAR_COIN_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

