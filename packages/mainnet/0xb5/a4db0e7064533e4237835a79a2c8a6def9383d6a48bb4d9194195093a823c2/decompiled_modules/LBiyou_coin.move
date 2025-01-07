module 0xb5a4db0e7064533e4237835a79a2c8a6def9383d6a48bb4d9194195093a823c2::LBiyou_coin {
    struct LBIYOU_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LBIYOU_COIN>, arg1: 0x2::coin::Coin<LBIYOU_COIN>) {
        0x2::coin::burn<LBIYOU_COIN>(arg0, arg1);
    }

    fun init(arg0: LBIYOU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBIYOU_COIN>(arg0, 6, b"LBIYOU", b"LBIYOUCOIN", b"LBIYOU Coin is so precious", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBIYOU_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBIYOU_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LBIYOU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LBIYOU_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

