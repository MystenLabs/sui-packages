module 0x67704a2f308c318df43045f1871e40285e7d9a89a360079bbb21c0001e5ea21d::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPEPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPEPE>(arg0, b"SPEPE", b"Splash Pepe", x"f09f90b8205468652066726f6720746861742063616e6e6f6e62616c6c656420696e746f206d656d65636f696e20686973746f7279", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPs9iNWAMW9CWxaJmGVHUvN6Uc4tAo7bp6ifwpgy1ScBR")), b"WEBSITE", b"https://x.com/suitankcoin", b"DISCORD", b"https://t.me/suitankcoin", 0x1::string::utf8(b"00dd82167554192f7ed613dde02632fa74346efe028f1ee86090bb71ef815134890d88fc270bbbd6eee0aa4893be3546b1294ece0fa5289cbfa040ecd52fee5900d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747838061"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

