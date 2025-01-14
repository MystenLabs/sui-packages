module 0xc0d9d571b16bc31634a4ccb7a0fcce6efd0c646e984ab3f360c5ea76857a5af6::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<TT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/e3edfa5c-a701-45e0-9ee5-5e3d7a7c8a47")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d3840cfa9aee2b1dd72f9d6102788893d706863d60bc6e8f3f3b94ca43367112113ad720a07aff9b25bafaf015b6cc290f016f09d5d26a9c2d623eb24f16100c4f82611d9e866a8067413980263454f7cf15e31fe03369ae5429340e5580457c1736844734"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

