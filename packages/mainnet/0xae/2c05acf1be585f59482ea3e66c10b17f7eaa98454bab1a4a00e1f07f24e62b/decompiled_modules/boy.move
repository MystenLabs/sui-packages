module 0xae2c05acf1be585f59482ea3e66c10b17f7eaa98454bab1a4a00e1f07f24e62b::boy {
    struct BOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BOY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BOY>(arg0, b"BOY", b"Boy", b"standing boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNNvt5XyHzfmQRmpfsFawJBzEYRsR4MYqWtz3NpA6JcmK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b187c6032853e270d0197897b7d0d2b00d5fb2f24d830854d288a58ef1ebf5521a96da0badeab68c52352dc699101857693036725b484645396d5b390430da04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748087919"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

