module 0x99f443b6941e8ab3df145b8586c386a47fb9ed6d6700b24da4e56e8b9d571fe3::mohip {
    struct MOHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOHIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MOHIP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MOHIP>(arg0, b"MOHIP", b"Mind Of Hippo", b"The Thinking Face of the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPX3Du7bQSoP1wGuLrpEzoSW22S2ag1TqgdLTkBFDBUfC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0068384a22f12a528bbfb75bea2247df89b458aef442554ee0c56da3095eed60035c95d574c8a8a248ab79c4558c372b2bd16331c22672cf3bea0bb69d4304b009d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749588362"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

