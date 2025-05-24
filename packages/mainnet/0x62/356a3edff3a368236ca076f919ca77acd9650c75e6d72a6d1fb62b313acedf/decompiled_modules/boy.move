module 0x62356a3edff3a368236ca076f919ca77acd9650c75e6d72a6d1fb62b313acedf::boy {
    struct BOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BOY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BOY>(arg0, b"BOY", b"Boy", b"standing boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNNvt5XyHzfmQRmpfsFawJBzEYRsR4MYqWtz3NpA6JcmK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cd215220fae20e465f2d2cd85af57c4e8b80a1547158c569ca7689849dd6679253fd459c836e85d1df52f2483f59ce667a5e6ecef6b60a4e70fdf1931962e700d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748088057"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

