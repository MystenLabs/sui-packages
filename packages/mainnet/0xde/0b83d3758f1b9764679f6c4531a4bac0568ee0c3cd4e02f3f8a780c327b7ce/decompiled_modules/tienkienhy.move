module 0xde0b83d3758f1b9764679f6c4531a4bac0568ee0c3cd4e02f3f8a780c327b7ce::tienkienhy {
    struct TIENKIENHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIENKIENHY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TIENKIENHY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TIENKIENHY>(arg0, b"TIENKIENHY", b"tienkienhy", b"I want tien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSRNcrPwp8kgG4bASJdA9ipVtpLC5BnojJ9onTTjk1urL")), b"WEBSITE", b"https://x.com/tienkienhy", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a109c39275c09890e43677a61082b2bd6f39ae6f090f29bc323d72858c116f071b5316cbb5cafbec94e47215b0465f0ce2a00cdb52ee9f8741fd5082b5132502d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748157569"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

