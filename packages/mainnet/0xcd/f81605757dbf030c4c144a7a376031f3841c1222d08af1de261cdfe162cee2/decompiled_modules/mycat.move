module 0xcdf81605757dbf030c4c144a7a376031f3841c1222d08af1de261cdfe162cee2::mycat {
    struct MYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MYCAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MYCAT>(arg0, b"Mycat", b"mibo", b"my cute cat~mibo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWa4mGrZSr3rx6t7rhatCxydTwp5mRQBSe8CPGUSsX27Y")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d5adf8f250e44e606c04bd15d8be84c9c08d013ae0d998b80496d30bc8753f242f7360c4eb9667428180a31e126ba3064104756bf489329ff2c18b86cc22880bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747891795"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

