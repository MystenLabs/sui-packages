module 0x5f907487d373813150b8bd93fc19cecf7b6d2c11f5a0b1a5834e136c1ce951fc::dor {
    struct DOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DOR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DOR>(arg0, b"DOR", b"Gorilla", x"476f72696c6c612028474f522920e2809420426f726e206f6e205355492c20726169736564206279206d656d6566692053706c6173682e0a4e6f74206a7573742061206d656d652e204974e280997320616e206170652d736f6c757465206d6f76656d656e742e20f09fa68df09f92a50a0a4675656c65642062792076696265732c2062616e616e61732c20616e64207075726520646567656e20656e657267792e0a4e6f20726f61646d61702c206a757374206a756e676c6520696e7374696e63742e0a4a6f696e2074686520726f61722e2024474f5220f09f9a80f09f8cb4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUbMzMuoM8f38V1moddKZ91wZeViLRSjb1nv3oaxqAfPA")), b"WEBSITE", b"https://x.com/Ren33077667", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00dd2f9d2a3c75f89485f258497293c3fe708f1b61b48804fc0ec3c32eca45c50f68b066c4a3fb1b6d7f783d59d4925e60373f739d5068bccbf0c6177d5c75710cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747812511"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

