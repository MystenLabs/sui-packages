module 0x154ba5f35a379227a18e98e6151bb158e1d7ab40038abf7292160078c7ea3750::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"Goatseus Maximus", b"GOAT", b"Goat Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

