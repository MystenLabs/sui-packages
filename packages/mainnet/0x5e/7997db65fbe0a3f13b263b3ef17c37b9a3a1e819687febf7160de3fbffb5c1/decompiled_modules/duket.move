module 0x5e7997db65fbe0a3f13b263b3ef17c37b9a3a1e819687febf7160de3fbffb5c1::duket {
    struct DUKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKET>(arg0, 6, b"DUKET", b"DUKET", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUKET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

