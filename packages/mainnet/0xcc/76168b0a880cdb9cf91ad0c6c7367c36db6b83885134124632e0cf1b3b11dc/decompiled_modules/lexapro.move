module 0xcc76168b0a880cdb9cf91ad0c6c7367c36db6b83885134124632e0cf1b3b11dc::lexapro {
    struct LEXAPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEXAPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEXAPRO>(arg0, 6, b"LEXAPRO", b"Lexapro On Sui", x"4c65786170726f206c6966656c696e650a0a68747470733a2f2f782e636f6d2f6c65786170726f6c6966656c696e650a68747470733a2f2f742e6d652f6c65786170726f7361766575730a68747470733a2f2f6c65786170726f6c6966656c696e652e636c75622f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241224_030059_438_1518cc23fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEXAPRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEXAPRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

