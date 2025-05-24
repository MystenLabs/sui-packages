module 0x5a46a88208e2cc7ca4f7bbd9c26a697ab232fb27dbe5b7a1689f7508318626bf::ayou {
    struct AYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYOU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AYOU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AYOU>(arg0, b"AYOU", b"Accompany You", x"41206d656d6520636f696e207468617420737469636b73207769746820796f75207468726f75676820746869636b20616e64207468696e20e2809420616c7761797320627920796f757220736964652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR3BAqeVRLSr412KGxaKDp8gh2P5uJxHteJTXyVGZrLwF")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00540af9b183e07febc984a1a5f2d436e8d81a5159a9b772e3e01d9273b324d1de5d6c8be91757ef7a393a543986931a64f50d4108584ef22e0e7f4e3e1093f70ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748051151"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

