module 0x5ce8faafec2988ede6b846988455b18748b74915aa81684c17b638cdf4f89524::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPEPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPEPE>(arg0, b"SPEPE", b"Splash Pepe", x"f09f90b8205468652066726f6720746861742063616e6e6f6e62616c6c656420696e746f206d656d65636f696e20686973746f7279", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPs9iNWAMW9CWxaJmGVHUvN6Uc4tAo7bp6ifwpgy1ScBR")), b"WEBSITE", b"TWITTER", b"DISCORD", b"https://t.me/splashpepe", 0x1::string::utf8(b"006457bcd7231291ace537bdf96dd875c9e298af2dbd158c9a675e22845e89b834f7618a969cf8520043aac725e28dbe59071b0ee9d5d0597c02d3e06742fd3c0bd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747838394"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

