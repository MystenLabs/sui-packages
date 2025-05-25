module 0x6c31b6991280e620d73d641929e290ee10078bf04cb7f41cb42476b9ed325066::sns {
    struct SNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SNS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SNS>(arg0, b"SNS", b"Home Sweet Home", x"486f6d6520537765657420486f6d650a534e53", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRn1RjtbBAe6BJWvEzXg8Jjx33SFKERg3MhL6yxj72v2r")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005acb8808cc95446905bf4f2931ce2f574761a5ab8124fc3eb89b1f046674191ff7c82f96b9c99f777af299d0773badcd18a05d2994c71ddc83d98c00a6b94b08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748181893"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

