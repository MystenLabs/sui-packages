module 0x859c8104afaede074a6aa41efca243514056ddafa38837f2e3fc433e01c8aa36::hum {
    struct HUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HUM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HUM>(arg0, b"HUM", b"hum", b"cutey hum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbXHchog3gffadTNoV1nyimnnnYCTdSs4NuSYPFfXRYRL")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004a1c84fdd58ea62c5dd1ba40c337135c841446e19af2c99602c00713f82d0daf3156907e40f43bf8828a7fe597c8547b75e6765c225d86407c3576f4ce39c800d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748088173"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

