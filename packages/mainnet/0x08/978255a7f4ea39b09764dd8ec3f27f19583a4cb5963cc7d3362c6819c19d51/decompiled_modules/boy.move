module 0x8978255a7f4ea39b09764dd8ec3f27f19583a4cb5963cc7d3362c6819c19d51::boy {
    struct BOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BOY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BOY>(arg0, b"Boy", b"Splash Boy", b"Splash boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPbHuikW1Ad5sfjgvmi4nU31ADxyjfUZ9mUSZEXRLYZKX")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c38bbd85940ce85695dbdf99d42bb177d159bb67a7ef8cc55d1e6ca18784e94085df3a911d76ea752ed571f9d0381ff7a7faa14a4d8b00fb0304eb0dce9c0b03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747881858"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

