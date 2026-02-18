module 0x9a6cd286ee5ff3b2ee85eadeed067c824e03fadefe91cc399bc58f20208ccba9::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 6, b"OCN", b"Ocean", b"Ocean Token - Fixed Supply 10M", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OCEAN>>(0x2::coin::mint<OCEAN>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OCEAN>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

