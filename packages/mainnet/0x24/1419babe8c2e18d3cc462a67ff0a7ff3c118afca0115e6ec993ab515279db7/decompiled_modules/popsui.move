module 0x241419babe8c2e18d3cc462a67ff0a7ff3c118afca0115e6ec993ab515279db7::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 6, b"POPSUI", b"popsui", b"popsui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<POPSUI>>(0x2::coin::mint<POPSUI>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

