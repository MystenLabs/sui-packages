module 0xba7637b85ecd70b086e01ff669e04d4921872369272377c0751a374bc273d7b2::ai_coin {
    struct AI_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI_COIN>(arg0, 9, b"AI", b"AI Coin", b"Ai Coin deployed At Sui Chain on cetus protocol For Project Ai coin And Nfts + Farming Yield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775496983417-3406c286bb9ee7021cd707cc924268bd.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AI_COIN>>(0x2::coin::mint<AI_COIN>(&mut v2, 21000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_COIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

