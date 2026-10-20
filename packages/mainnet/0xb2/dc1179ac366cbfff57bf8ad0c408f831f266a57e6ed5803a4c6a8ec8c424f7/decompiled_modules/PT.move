module 0xb2dc1179ac366cbfff57bf8ad0c408f831f266a57e6ed5803a4c6a8ec8c424f7::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT>(arg0, 6, 0x1::string::utf8(b"PT-eSUI"), 0x1::string::utf8(b"PT-eSUI"), 0x1::string::utf8(b"PT token for Jitter Ember eSUI, maturity 2027-01-19."), 0x1::string::utf8(b"https://bluefin.io/images/logos/egSUI.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PT>>(0x2::coin_registry::finalize<PT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

