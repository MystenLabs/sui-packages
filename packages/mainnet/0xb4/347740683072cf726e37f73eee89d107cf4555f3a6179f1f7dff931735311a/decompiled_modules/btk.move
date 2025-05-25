module 0xb4347740683072cf726e37f73eee89d107cf4555f3a6179f1f7dff931735311a::btk {
    struct BTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BTK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BTK>(arg0, b"BTK", b"bitken", b"BITKEN demo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSqfL6VYJ4hDEKJqnhNDruKsoMBegGf4YbSoNsvDzZxQ1")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ec2ce01654a036a867e2f652b35c6fb9efb41f76e79b201345b3b25ae712d88ff0b1d32baa97c537d722ac00ea528e3688fcf5cdade9d23bc55e0212536da205d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748165546"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

