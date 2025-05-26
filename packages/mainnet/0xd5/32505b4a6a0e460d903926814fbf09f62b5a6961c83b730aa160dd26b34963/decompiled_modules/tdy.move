module 0xd532505b4a6a0e460d903926814fbf09f62b5a6961c83b730aa160dd26b34963::tdy {
    struct TDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TDY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TDY>(arg0, b"TDY", b"Teddy", x"e2809c49276d2073656c666973682c20696d70617469656e7420616e642061206c6974746c6520696e7365637572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcuKLYSNFySyy1qs1CT2mG7uvVKAPgn5QGUEN5sBm5Hn4")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004b273983669b5e069cfa3957f2d51d0304de980a96a518b9f6fe673b47f0588def53541d55590912fb5bcfa97b2bb43213c87d5e01def3d5ec9b9dc99c358a07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748220221"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

