module 0x1e73ca19a94da6340453efd49e388e3405d8e6bb4c6d719ba07d4ff6800439da::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIDOGE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIDOGE>(arg0, b"SUIDOGE", b"SUIDOG", x"61e2808661e2808661", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma8jiVkuCadb7h4VMYJS8V7vBdfqZtvRpgComTBHKFtjQ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0067287f7ed60db41ed7e72f6430308bd6a7eefa6bf2201602a2065f7ad1a9d289d5ae4bffddd7e17dbae5032cd0f07973b9bbc05c9685871fb876724b0a45ab04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756573"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

