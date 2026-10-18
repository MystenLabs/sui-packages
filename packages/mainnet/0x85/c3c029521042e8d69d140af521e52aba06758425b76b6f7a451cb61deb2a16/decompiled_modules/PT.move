module 0x85c3c029521042e8d69d140af521e52aba06758425b76b6f7a451cb61deb2a16::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT>(arg0, 6, 0x1::string::utf8(b"PT-sSUI"), 0x1::string::utf8(b"PT-sSUI"), 0x1::string::utf8(b"PT token for Jitter Scallop sSUI, maturity 2027-01-17."), 0x1::string::utf8(b"https://admin.jitter.fi/ssui.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PT>>(0x2::coin_registry::finalize<PT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

