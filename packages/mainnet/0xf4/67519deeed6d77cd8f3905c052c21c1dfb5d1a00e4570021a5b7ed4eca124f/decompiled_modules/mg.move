module 0xf467519deeed6d77cd8f3905c052c21c1dfb5d1a00e4570021a5b7ed4eca124f::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MG>(arg0, b"MG", b"Magic Labs", b"Magic MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNVR9gRrjv8bZ3WHZGbUXa2mq11D1wT2Emd3jriLTQnFc")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00851f50f280aa61dd697e8c6ea94b1c31e96f64ce456c568d98d9b47f65ce4c91558284080e20f6846dfcc70f0615083f4180b35dd85da2db8f3db11b21fc880fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748062352"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

