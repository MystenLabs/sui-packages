module 0x2fe67540c50ca3dfeb63368b9fc92c998b83cb90b01c2ee1088e561419eed200::bndrt {
    struct BNDRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNDRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNDRT>(arg0, 6, b"BNDRT", b"Binderoo Token", x"42696e6465726f6f20546f6b656e20e280942042696e6465726f6f2062696e64657220746f6b656e", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNDRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNDRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

