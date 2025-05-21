module 0xfaf163452f71b3006bb1e27e4b0caceb77e648e2a515bbea28cb7d453bfdb76f::fwal {
    struct FWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWAL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FWAL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FWAL>(arg0, b"FWAL", b"Flash Walrus", b"Flash Walrus Version", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXAFQ1fRSmtDV25Re6v1KA2aP5e3RyZPxbp5wEca9XRSa")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0007102b8aabf973ecb7fbdf30274b1b1f44393e840c01ba7c0a05fea2ab79a17acc62e3eb9a15f08e4be5ccb99579a6ff16997747d9ba13071a14ebbb2f2ceb05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747798873"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

