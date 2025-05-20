module 0xf3acdbd3efec4307bedfdcb75564ac624a4ecbfc80f0ee0a8f2d5a0165ee8eb8::sww {
    struct SWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SWW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SWW>(arg0, b"SWW", b"SUIWAWA", b"Dont buy, please only doggy sui fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZNoXnEoU37GVVxxj5h4YaFbFvieVSN3Q9E4DfgTXn8f2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0075c6e4dc9eb1dbfa3c15d47aed7f74d25007b039783b5b76be48cad52fd1f02a2baeadc4dadc793d13e75a0d1bb8c77924b8c74743e9ee309e7792b2b3ab9208d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747774874"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

