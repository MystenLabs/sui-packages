module 0xf0e58129c1b26a3b8f607eb2e952b95b3e8b8e5d851a5d63e1a416902b374039::berry {
    struct BERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BERRY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BERRY>(arg0, b"BERRY", b"Strawberry In Bloom", x"4e65772046656d616c652046726f67207c204d6174742046757269652773206d656d6520e28094205374726177626572727920496e20426c6f6f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmbar6RpfwKijJ4mbDacsc3mkEWjZ5VvFoPmKxZVt8UNFj")), b"https://www.berrycoineth.vip/", b"https://x.com/berrycoineth", b"DISCORD", b"https://t.me/StrawberryInBloom", 0x1::string::utf8(b"00e72bf50e32d1d22cc72f84a336b24aef798af2005334e6fa976a4dbf747685b59282059330dd5cc14675b67b10781c8ea1a03f929abd248c2148d6ced4ec5009d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747760028"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

