module 0x29b90fbef050c0da1fbb8b3085f730684ce8371f757fcbfe25002e0e8637b60b::stsla {
    struct STSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STSLA>(arg0, 8, 0x1::string::utf8(b"sTSLA"), 0x1::string::utf8(b"Tesla xSpot"), 0x1::string::utf8(b"One coin per Tesla xStock (TSLAx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the TSLAx multiplier)."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSLA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<STSLA>>(0x2::coin_registry::finalize<STSLA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

