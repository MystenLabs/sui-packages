module 0xbbc7ceea6a6728a6a46a5303f7078f9798dba224314c76826fa160af5cbdac01::grad {
    struct GRAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAD>(arg0, 9, b"GRAD", b"Arena Grad", b"graduation lock smoke", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

