module 0xb6256381009a8ffc4ef91b0579b977af8b0ef620a23b8224fcff1fe2cc82812d::YT {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT>(arg0, 6, 0x1::string::utf8(b"YT-sUSDsui"), 0x1::string::utf8(b"YT-sUSDsui"), 0x1::string::utf8(b"YT token for Jitter Scallop sUSDsui, maturity 2027-01-19."), 0x1::string::utf8(b"https://xmalnrwtxuhoijrcua3gf3y22fa3r5fjyvvrqjxyp4udip2uew7a.turbo-gateway.com/uwC2xtO9DuQmIqA2Yu8a0UG49KnFaxgm-H8oND9UJb4"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YT>>(0x2::coin_registry::finalize<YT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

