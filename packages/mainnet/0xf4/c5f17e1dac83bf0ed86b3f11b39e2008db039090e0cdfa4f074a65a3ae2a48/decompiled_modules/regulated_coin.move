module 0xf4c5f17e1dac83bf0ed86b3f11b39e2008db039090e0cdfa4f074a65a3ae2a48::regulated_coin {
    struct REGULATED_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REGULATED_COIN>(arg0, 5, b"STABLE$", b"RegulaCoin", b"Example Regulated Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(0x2::coin::mint<REGULATED_COIN>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REGULATED_COIN>>(v1, v4);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGULATED_COIN>>(v2, v4);
    }

    // decompiled from Move bytecode v6
}

