module 0x1acf9c0371fd67b33d040a31cc59a5934f92e384d3862db5b3e1df10f9835e63::regulated_coin {
    struct REGULATED_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REGULATED_COIN>(arg0, 5, b"KAPOGIAN$", b"KapogianCoin", b"Ang Coin ng mga Pogi", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REGULATED_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGULATED_COIN>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

