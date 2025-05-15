module 0x4168c0c00a752fdc21b5ce23002d13318c9bedd06624be4ba791e3eb8581f39d::ojkk {
    struct OJKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OJKK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<OJKK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<OJKK>(arg0, b"OJKK", b"OJKK Token", b"this is OJKK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004fef48634d634b95f5fd0b1b2d809c6b0b7fc36e595bb6f70b338bb3e3654739635132dd5744597deefaa36391b4609a063493d74f0103ab4d3d3208f073990ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747321115"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

