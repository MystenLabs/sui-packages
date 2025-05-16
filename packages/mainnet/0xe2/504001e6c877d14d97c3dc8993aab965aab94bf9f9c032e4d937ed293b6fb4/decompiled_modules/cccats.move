module 0xe2504001e6c877d14d97c3dc8993aab965aab94bf9f9c032e4d937ed293b6fb4::cccats {
    struct CCCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCCATS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CCCATS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CCCATS>(arg0, b"CCCATS", b"Token", b"Desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2yn8Gvwa2updz5KcTzQJ9uXKaPikKiZnnKMLDX2miC5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d6bd29eb99037821d50a352fe5da2f567ec6e49dcc1860a3345a24856389d3800c0fe1417fa159e14f7eebaa0682b9d6412061c25e887847ed6fa2b14e3c2007d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747408798"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

