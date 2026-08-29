module 0x8c56326db33511006d6dfa74246dc97df12ce0168bfc231003a79cc2599dff82::bfln {
    struct BFLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFLN>(arg0, 9, b"BFLN", b"Arena Bluefin", b"bluefin seed smoke", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BFLN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

