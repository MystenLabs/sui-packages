module 0xe771d46eb1e61a13a70601811f9beb38c8d2f3c07806295e2f5363bfdb297f89::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT>(arg0, 6, 0x1::string::utf8(b"PT-sUSDsui"), 0x1::string::utf8(b"PT-sUSDsui"), 0x1::string::utf8(b"PT token for Jitter Scallop sUSDsui, maturity 2027-01-19."), 0x1::string::utf8(b"https://xmalnrwtxuhoijrcua3gf3y22fa3r5fjyvvrqjxyp4udip2uew7a.turbo-gateway.com/uwC2xtO9DuQmIqA2Yu8a0UG49KnFaxgm-H8oND9UJb4"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PT>>(0x2::coin_registry::finalize<PT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

