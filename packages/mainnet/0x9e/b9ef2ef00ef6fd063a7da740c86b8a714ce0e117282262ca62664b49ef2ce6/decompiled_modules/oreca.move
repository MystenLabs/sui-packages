module 0x9eb9ef2ef00ef6fd063a7da740c86b8a714ce0e117282262ca62664b49ef2ce6::oreca {
    struct ORECA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORECA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORECA>(arg0, 6, b"ORECA", b"OrecA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORECA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORECA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

