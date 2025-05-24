module 0xfbece71f2dd1dd0fe84e9a9ef7a3a1421b293269fe087fa21e0779594c6e0479::quai {
    struct QUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<QUAI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<QUAI>(arg0, b"QUAI", b"Quai", b"Quai Genesis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYh5JpMwuNHCZMawk3j1VD3B3C2GzckaeuQuQzDgCLe4k")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bdcc3f0c1f0e3c28832ead962396c61d91719849ce8c8caa38519f8899e86a00474645dff4e4302d420973f98cd4cfd20766c94ac7e5c19f6f1aa7f00c3dcd04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748097255"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

