module 0x34ce1d51588b54c5b30ea91d8338711f1e2c278ec5a2d363627591d69a15e536::sclacic {
    struct SCLACIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCLACIC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SCLACIC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SCLACIC>(arg0, b"SCLACIC", b"SUICLASICC", b"I don't intend anything with its creation, just to thank Sui for his great work.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfRdicJK2JtpjNYDRvh3dpxWiPnGdcwDU9c3HhHk2mDxP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0049c6725da30390fe80b890040ebfa9a7c161040f2eb1b4fd56db96e5070776ddc7665d0fc87774698049c94cdf35a23417818157b06b4c78afd7358a49a4180bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748103634"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

