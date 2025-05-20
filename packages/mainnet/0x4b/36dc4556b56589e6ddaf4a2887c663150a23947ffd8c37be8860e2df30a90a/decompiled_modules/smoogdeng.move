module 0x4b36dc4556b56589e6ddaf4a2887c663150a23947ffd8c37be8860e2df30a90a::smoogdeng {
    struct SMOOGDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOOGDENG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SMOOGDENG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SMOOGDENG>(arg0, b"SMOOGDENG", b"Splash MooDeng", b"memecoin of Moo Deng on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXRfmWsgPRagJqZ5cUHWhgwVFbXuLAYCLRu8NchHU1FDd")), b"WEBSITE", b"https://x.com/MooDengSOL", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f89b52261e526238581dbe29741258c2064e15a079051691f5f31ef8900e80b32e05ccf82c2de328062eb017891bfe7b5bfe647876594349f4d95a30423ec501d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758346"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

