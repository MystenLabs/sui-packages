module 0x8fc92314633902ad903620412d4ecfe800f377a20032925ee1f2f4af2b170141::mgl {
    struct MGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MGL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MGL>(arg0, b"MGL", b"Magic Labs", b"Magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNVR9gRrjv8bZ3WHZGbUXa2mq11D1wT2Emd3jriLTQnFc")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00173cc9e4f2dfb4f707bb8dcb0ce4c2a353eb12d110f202a47e19b6ae42990b2eea6342f30ec22e065e29f50b2643e3ce95552207b3c843833e1f3313ca8d8009d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748062219"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

