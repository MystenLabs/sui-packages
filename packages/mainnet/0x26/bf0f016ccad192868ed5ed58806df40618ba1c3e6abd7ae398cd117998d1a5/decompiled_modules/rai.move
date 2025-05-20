module 0x26bf0f016ccad192868ed5ed58806df40618ba1c3e6abd7ae398cd117998d1a5::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RAI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RAI>(arg0, b"RAI", b"Reploy", b"Create and scale web3 projects with AI superpowers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZ8FyN2Hhc9ZJDpj5bqcFt6Upxa4DLPtY5xYrK5KuLvta")), b"https://www.reploy.ai/", b"https://x.com/Reployai", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00217d0adb0e619120d11811bb9f1047ca3f7d0cd65bcaa63809807cfe10a9468393301399b44941e2d6bfaa4b2ac2ffbdde903278747df1ecf3325427a4ca7a0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747766250"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

