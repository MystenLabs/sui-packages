module 0xda23510a90f12cc9cd55538b9c7d3eb9f6f1a371835ab50e6d5599266ac97bc5::justin_coin_6 {
    struct JUSTIN_COIN_6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTIN_COIN_6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTIN_COIN_6>(arg0, 6, b"DEC6", b"Decimals 6", b"Coin with 6 decimals for testing purposes.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTIN_COIN_6>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JUSTIN_COIN_6>>(v0);
    }

    // decompiled from Move bytecode v6
}

