module 0x12208b78999e7df4c35e057ebac5862ca9627f1d87bd169baa1e891fd250f16a::rof {
    struct ROF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROF, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ROF>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ROF>(arg0, b"ROF", b"Red Off", b"red stone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZFGz4jSSrZx5WVfE1zsT7USYmBtddQGM7cU6tZn9YAH9")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b139466db0f38e5197b38e894c602cd4cafc5f66fbcab73e9bb20fffe4fa8839a6982b8e6896d7c9de99dd5d9c9f3f2fb6cc48ddcd2531ed2112d49f8615a308d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748093290"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

