module 0x1925a5e673fd784046e49a0c1aed165a97c9b3201a139ed349026a96e2d80207::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUN>(arg0, b"SUN", b"WHITE SUN", b"THE WHITE SUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUuTG3QhQ3ZmsztAptS7G8TfydkJPCNjBbuA2NidvSGkM")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00939af7e138dd92a85aa23fd3559cc92e55fea48b0e392a58be2f59b8373be76bb5ee0f597730c926ae4aa6720406fd2d55a299c927ac0aa812281b2ce72bf507d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749541615"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

