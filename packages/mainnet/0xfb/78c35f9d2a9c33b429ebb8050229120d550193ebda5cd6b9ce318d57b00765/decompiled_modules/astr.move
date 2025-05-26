module 0xfb78c35f9d2a9c33b429ebb8050229120d550193ebda5cd6b9ce318d57b00765::astr {
    struct ASTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ASTR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ASTR>(arg0, b"ASTR", b"AISTAR", b"AISTAR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNaHi8qEy4uk1ytzeJ1i4p779Go5gXBsYZThMpHFNsqkX")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008e47ab841e605189cd51cf8fd3147e8b84ac8ddfabf4dd5788f0cb6836d82487848e511873e4be28f900d667e4d87b071c88731187a349f0398ae1dbf9403409d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748267020"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

