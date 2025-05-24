module 0xe6030ba1c2a48d037d7203af29fd5cfc9a54ec38b3f1f6cdb0561f16e603c45b::paimon {
    struct PAIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIMON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PAIMON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PAIMON>(arg0, b"PAIMON", b"HAIL PAIMON", b"Paimon, a king of heaven in demonology and mythology traditions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQag5mqdx47YFtSX2EL9c3qgp3h3rMX59XAS9JTT3gsJh")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0018c283c19a9de876894bff3f4d5744d0a46605f46190457c5b3d2117b9880acdda07f418a553831341f6be8f033232ba29474bddd99a9d2b4fac467815409e0ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748075484"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

