module 0xfa3fc156dd659a4ca8bdd8f20f8baa058b84019df91f999a074ab34b47b86880::binks {
    struct BINKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINKS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BINKS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BINKS>(arg0, b"BINKS", b"SPLASH", b";)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXCggNdfxcqdMSojQhV2RbSGhEdN6sgDp4qnZsfFyzGXi")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e934e81d5a9e48736a3b2335159485e72569c46119d21c6e1db1e1a4a65e2e7cbc8a957b42fc1a3dbc0c9513abd07aadbdbee6d144e2c0c9a08c9eb84935b101d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756430"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

