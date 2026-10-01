module 0x621989cdbf272a02772279bae49eee012392fad82846356f2151638ec6fd4682::obpop {
    struct OBPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OBPOP>(arg0, 6, 0x1::string::utf8(b"OBPOP"), 0x1::string::utf8(b"OURBLAST Popular Test"), 0x1::string::utf8(b"Integration test launch by OURBLAST on POPULAR."), 0x1::string::utf8(b"https://ourblast.xyz/icon-192.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBPOP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<OBPOP>>(0x2::coin_registry::finalize<OBPOP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

