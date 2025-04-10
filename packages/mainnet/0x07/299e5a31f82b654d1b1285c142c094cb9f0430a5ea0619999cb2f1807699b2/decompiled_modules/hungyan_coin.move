module 0x7299e5a31f82b654d1b1285c142c094cb9f0430a5ea0619999cb2f1807699b2::hungyan_coin {
    struct HUNGYAN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HUNGYAN_COIN>, arg1: 0x2::coin::Coin<HUNGYAN_COIN>) {
        0x2::coin::burn<HUNGYAN_COIN>(arg0, arg1);
    }

    fun init(arg0: HUNGYAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNGYAN_COIN>(arg0, 5, b"USD", b"hungyan coin", b"Test coin for move study", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNGYAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUNGYAN_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HUNGYAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HUNGYAN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

