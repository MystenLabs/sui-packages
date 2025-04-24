module 0x121014f75f4e2e1a8687fa25eb79df01d1375ab524814044102fcee103a59d68::fart_coin {
    struct FART_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART_COIN>(arg0, 6, b"FART", b"FartCoin", b"Fartcoin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FART_COIN>>(0x2::coin::mint<FART_COIN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FART_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FART_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

