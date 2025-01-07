module 0xc55a4163bfa08adbeee26f56c508e6d2bd5c8a68b5b0764dfc12b271000d6e59::lgcoin {
    struct LGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGCOIN>(arg0, 6, b"LGCOIN", b"Lugon Token", b"Testing purpose", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

