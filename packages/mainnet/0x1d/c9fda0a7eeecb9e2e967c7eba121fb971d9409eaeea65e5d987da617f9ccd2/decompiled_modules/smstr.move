module 0x1dc9fda0a7eeecb9e2e967c7eba121fb971d9409eaeea65e5d987da617f9ccd2::smstr {
    struct SMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SMSTR>(arg0, 8, 0x1::string::utf8(b"sMSTR"), 0x1::string::utf8(b"Strategy xSpot"), 0x1::string::utf8(b"One coin per Strategy xStock (MSTRx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the MSTRx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/mstr.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMSTR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SMSTR>>(0x2::coin_registry::finalize<SMSTR>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

