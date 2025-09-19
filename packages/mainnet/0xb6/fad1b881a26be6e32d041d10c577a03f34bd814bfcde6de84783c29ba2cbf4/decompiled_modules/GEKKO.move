module 0xb6fad1b881a26be6e32d041d10c577a03f34bd814bfcde6de84783c29ba2cbf4::GEKKO {
    struct GEKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEKKO>(arg0, 9, b"gekkocoin", b"GEKKO", b"gekko", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GEKKO>>(0x2::coin::mint<GEKKO>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEKKO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEKKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

