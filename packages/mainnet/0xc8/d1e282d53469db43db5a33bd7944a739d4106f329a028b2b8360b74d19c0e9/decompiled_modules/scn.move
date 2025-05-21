module 0xc8d1e282d53469db43db5a33bd7944a739d4106f329a028b2b8360b74d19c0e9::scn {
    struct SCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SCN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SCN>(arg0, b"SCN", b"Splash Scan", b"Track tokens, run insights, and buy instantly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQSCZBQchm7EdGT7yYXWzx9DZzaRESiC79cCSxDamtbY8")), b"https://www.splashscan.live/", b"https://x.com/SplashScan", b"DISCORD", b"https://t.me/SplashScan", 0x1::string::utf8(b"00f822bb96172be8ba569a5344a35d29075b18f2eb78423a4a90cdb9d078c4e9055483bc0e72f374e392678b5bf7981210d232538005a533fbe61263fa6ca1a400d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747854373"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

