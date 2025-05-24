module 0xadff4ffc84ece1bea18631a5cc58341539b07b9298d7438346130abdfeb73b8c::fro {
    struct FRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FRO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FRO>(arg0, b"FRO", b"Frosui Amphibiano", x"46726f73756920416d7068696269616e6f20697320612066756e20616e64207574696c6974792d64726976656e20746f6b656e206f6e2074686520535549206e6574776f726b2c20706f776572696e67204465466920616e64204e46542065636f73797374656d732077697468207374616b696e672c20726577617264732c20616e6420612076696272616e7420636f6d6d756e6974792e20f09f90b8f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNaJTEGmBXFB5RjVzpAMj8AnRp8KiwWbomLyUwiFv3SnV")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cf42b2bc3d1cf875b971314cea4c8384066aa5f579235db27513b309772648dd1604343e183b45e5525257a1ceeddc28e120cb52fabb6422fd6152d34fc33801d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748093353"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

