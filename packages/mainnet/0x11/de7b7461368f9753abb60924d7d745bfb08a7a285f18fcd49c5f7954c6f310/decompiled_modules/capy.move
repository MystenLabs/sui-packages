module 0x11de7b7461368f9753abb60924d7d745bfb08a7a285f18fcd49c5f7954c6f310::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CAPY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CAPY>(arg0, b"CAPY", b"Capy Coin", x"2443415059202d20746865206368696c6c657374206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2120200a566962696ee28099206c696b65206361707962617261732c207765e28099726520616c6c2061626f757420636f6d6d756e6974792c2064616e6b206d656d65732c20616e642065617379206761696e732e20537569e2809973207370656564792c206c6f772d666565207669626573206b65657020757320726f6c6c696ee280992e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX9RmYVzRQJDyhH2PzjUcgH4hX1dCNPRFdPDds3Zqx1ZS")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006c63bf2bbfbf970b061beca68fa9b6d2be7c0ce572716834866731cc144122de44b8a2c7c65c1df31723178c2dd9e8bdb42911d7ba663cc35eaa921518bcd601d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747764297"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

