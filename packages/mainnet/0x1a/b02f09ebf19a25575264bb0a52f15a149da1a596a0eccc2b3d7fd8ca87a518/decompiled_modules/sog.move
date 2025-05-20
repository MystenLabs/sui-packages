module 0x1ab02f09ebf19a25575264bb0a52f15a149da1a596a0eccc2b3d7fd8ca87a518::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SOG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SOG>(arg0, b"SOG", b"SuiMogCoin", x"496620736f6c616e6120686173204d4f470a5468656e205355492077696c6c206861766520534f47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTgXqG6MhsAPKMLPPFLkhhNLU1MNbm3SzqPYkcP6WvUn1")), b"WEBSITE", b"https://x.com/Suimogcoin", b"DISCORD", b"https://t.me/Suimogcoin", 0x1::string::utf8(b"009dcc338d6e254159367ac20e04b191063b4d34081db52ce35da219e519fef9947d508adcdfdf0395c02cf9800fbeddf2f0b7497537cb87a8f87e096956e4a109d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747760797"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

