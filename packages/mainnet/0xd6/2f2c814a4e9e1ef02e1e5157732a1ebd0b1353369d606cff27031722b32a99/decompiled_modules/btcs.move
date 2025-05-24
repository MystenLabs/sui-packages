module 0xd62f2c814a4e9e1ef02e1e5157732a1ebd0b1353369d606cff27031722b32a99::btcs {
    struct BTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BTCS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BTCS>(arg0, b"BTCS", b"BTC on Steroids", x"4254432077656e7420746f20746865204d6f6f6e20616e6420776520616c6c206c697665642068617070696c7920657665722061667465722e200a54484520454e44212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaTk3TvexeXwmNfPhd9LDSgF3wsyifo7qFEk3UEdmVsum")), b"WEBSITE", b"TWITTER", b"DISCORD", b"https://t.me/Jeastbassey", 0x1::string::utf8(b"0092c876216dde0e9f00ca2dc7efe7fe92078a8b616c02e855eded7dc6a8538002e2be4c62f3d6f010c34bfe1d8200cde301c20e9254ec78acd38ee07ac6aa0507d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748045689"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

