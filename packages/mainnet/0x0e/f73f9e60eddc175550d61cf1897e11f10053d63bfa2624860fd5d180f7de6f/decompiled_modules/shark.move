module 0xef73f9e60eddc175550d61cf1897e11f10053d63bfa2624860fd5d180f7de6f::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHARK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHARK>(arg0, b"SHARK", b"shark", b"Beauty at the peak of violence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaZHW4wRh26GXTG1JzNbcFKRc7Ev87MHbENyM3tGYeKft")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c18124d3253d2b73f1449d3effca2936ae24ab981d02e3abc08833f7e7e5e41542fc6a6ab8de358d4d31667df752d5abb65fca9473c5c97b77e2de62c548b00cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748205541"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

