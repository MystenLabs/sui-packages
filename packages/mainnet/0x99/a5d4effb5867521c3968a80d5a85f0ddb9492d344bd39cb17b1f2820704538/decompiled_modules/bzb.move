module 0x99a5d4effb5867521c3968a80d5a85f0ddb9492d344bd39cb17b1f2820704538::bzb {
    struct BZB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BZB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BZB>(arg0, b"BZB", b"BLUE ZORB", b"ON FIRE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRcZ9AfrizTeuVqqey4PprDFxPXwJzbj9qjdPFM5cbWvs")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fead3205d0c30757a18890684205f78dc64a448760d6ee9aed93637b5014512054d94a4be89f860f7c477438c1f048ced15b350d64cf4082a6ab83aa18b14301d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748196492"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

