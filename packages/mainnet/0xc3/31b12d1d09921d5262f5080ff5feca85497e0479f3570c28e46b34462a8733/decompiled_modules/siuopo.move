module 0xc331b12d1d09921d5262f5080ff5feca85497e0479f3570c28e46b34462a8733::siuopo {
    struct SIUOPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUOPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUOPO>(arg0, 6, b"SIUOPO", b"siuopo", b"siuopo", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUOPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIUOPO>>(0x2::coin::mint<SIUOPO>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUOPO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

