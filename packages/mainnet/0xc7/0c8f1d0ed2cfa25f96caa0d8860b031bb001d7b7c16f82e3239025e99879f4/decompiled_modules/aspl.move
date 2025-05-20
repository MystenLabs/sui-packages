module 0xc70c8f1d0ed2cfa25f96caa0d8860b031bb001d7b7c16f82e3239025e99879f4::aspl {
    struct ASPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASPL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ASPL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ASPL>(arg0, b"ASPL", b"As Splash", b"The worst feeling in the world, Socials soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbxczKmqeCPY4VqKTc3oLqHm5CsAZPsrDdcwvpV2Qer44")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f4c9f96ff080d5fc4ff8518cd510bd49ee06b3c60b3b39504bf0a0fa1da92484af56f98491df35b1fe76381b587ec29d730479b9e2164c45264d51ab27d73206d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747762559"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

