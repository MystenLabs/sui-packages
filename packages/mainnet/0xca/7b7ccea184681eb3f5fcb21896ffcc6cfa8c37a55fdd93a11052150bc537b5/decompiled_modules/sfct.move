module 0xca7b7ccea184681eb3f5fcb21896ffcc6cfa8c37a55fdd93a11052150bc537b5::sfct {
    struct SFCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SFCT>(arg0, 6, 0x1::string::utf8(b"Sfct"), 0x1::string::utf8(b"SuiFartCatTest"), 0x1::string::utf8(b"Testing fp"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/magma.jpeg/public"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFCT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SFCT>>(0x2::coin_registry::finalize<SFCT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

