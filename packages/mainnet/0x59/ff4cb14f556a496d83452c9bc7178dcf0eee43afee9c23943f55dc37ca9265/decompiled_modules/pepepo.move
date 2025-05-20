module 0x59ff4cb14f556a496d83452c9bc7178dcf0eee43afee9c23943f55dc37ca9265::pepepo {
    struct PEPEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PEPEPO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PEPEPO>(arg0, b"Pepepo", b"Pepe Hippo", b"Pepepo is where the legendary vibes of Pepe the Frog meet the calm power of a hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRNEGvM3BRvHn7FE7nuQUJUDgEAth2y78ihZ9mMSXB6gw")), b"WEBSITE", b"https://x.com/hippo_cto/status/1923364764954026426", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d3314937486d7b91d25a1ba16ad183554b705535db8339f55dc11644cce8739f53fb93c92b08ce1d7f2be2cce74d3b2c5a28f56a38d744f9050e799b0033630fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747769477"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

