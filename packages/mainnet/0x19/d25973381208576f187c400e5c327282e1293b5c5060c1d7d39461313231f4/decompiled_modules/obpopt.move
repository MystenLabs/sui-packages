module 0x19d25973381208576f187c400e5c327282e1293b5c5060c1d7d39461313231f4::obpopt {
    struct OBPOPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBPOPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OBPOPT>(arg0, 6, 0x1::string::utf8(b"OBPOPT"), 0x1::string::utf8(b"OURBLAST Popular Test"), 0x1::string::utf8(b"Integration test launch by OURBLAST on POPULAR."), 0x1::string::utf8(b"https://ourblast.xyz/icon-192.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBPOPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<OBPOPT>>(0x2::coin_registry::finalize<OBPOPT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

