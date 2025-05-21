module 0x8eeb3752580d279a147dcf66d00d5e22c82e2cf3b61c959750906de7f9151a7c::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<JIGGLY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<JIGGLY>(arg0, b"JIGGLY", b"PuffJiggly", b"The Pink Puffball Powering the Sui Meme Meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNfrkwS9szEcKJ1ihZTgzTsveez3BgmD4F5NjHw5JNzPo")), b"https://jigglywiggly.xyz/", b"https://x.com/Puffjiggly82633", b"DISCORD", b"https://t.me/puffjigglysui", 0x1::string::utf8(b"00ce99068a8f1341402282de4b347c559a2d638231c778554e56ed7bbb621a1abc5ef1fbd2b212019d40f471278fe0e21b025bbe81a15225424a6eecc12ba25d0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747838218"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

