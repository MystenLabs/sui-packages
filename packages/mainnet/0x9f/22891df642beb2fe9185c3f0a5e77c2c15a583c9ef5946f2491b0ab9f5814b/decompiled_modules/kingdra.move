module 0x9f22891df642beb2fe9185c3f0a5e77c2c15a583c9ef5946f2491b0ab9f5814b::kingdra {
    struct KINGDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDRA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KINGDRA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KINGDRA>(arg0, b"KINGDRA", b"Kingdra", b"Journey To the King of SuiSea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmT4iQCutjMx6kTduj5YUoKwoecPtnYhaR3tkZB7Zgfqb4")), b"https://kingdra.xyz/", b"https://x.com/Kingdra_Sea", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00412cdeb1129dc8859b9370098d1b35548cea1f42636bbd985e6bb3e5c688c4906c0f5bf4dfad1501bd093518398c75a57a1ea67c52cea0fd4ee5268ba45d400ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747827582"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

