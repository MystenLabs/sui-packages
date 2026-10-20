module 0xa7fde3cea1c89e881414e090fb8b520e5e93b65583b5f3dfeb0c68c4dbfdd41d::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT>(arg0, 6, 0x1::string::utf8(b"PT-sUSDC"), 0x1::string::utf8(b"PT-sUSDC"), 0x1::string::utf8(b"PT token for Jitter Scallop sUSDC, maturity 2027-01-19."), 0x1::string::utf8(b"https://admin.jitter.fi/susdc.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PT>>(0x2::coin_registry::finalize<PT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

