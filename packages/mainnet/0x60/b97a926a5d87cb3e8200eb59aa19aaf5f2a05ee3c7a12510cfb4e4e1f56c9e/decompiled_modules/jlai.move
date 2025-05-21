module 0x60b97a926a5d87cb3e8200eb59aa19aaf5f2a05ee3c7a12510cfb4e4e1f56c9e::jlai {
    struct JLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JLAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<JLAI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<JLAI>(arg0, b"JLAI", b"jianlai", b"fdsfdds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfAC6sLjTkN6PBWwGgyr4NBegm6odZ2BfuMVh9s41QtQy")), b"https://x.com/hookeke3", b"https://x.com/baohoo3", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b1b764dd9488adc80c2d16837791bfa76582dbf45361952cf792e1091620af342eca15cff0bc5c902e3d4d1e99bacbad37640b8b3eec860c007f63dc5c358803d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747811884"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

