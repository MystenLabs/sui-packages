module 0xa91d2e3578c6ddae7a8dd821f47e390b21af605cc00f00b1b1bddefb09ac6257::testsui {
    struct TESTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TESTSUI>(arg0, 9, 0x1::string::utf8(b"TESTSUI"), 0x1::string::utf8(b"Test SUI (POPULAR staging, worthless)"), 0x1::string::utf8(b"Quote coin for POPULAR's staging copies. Worthless, not SUI, not for trading."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTSUI>>(0x2::coin::mint<TESTSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TESTSUI>>(0x2::coin_registry::finalize<TESTSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

