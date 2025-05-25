module 0x96e8b15459816f3178184b615f752cf72ccef2911cfd464160fe1c7cdff35a36::dps {
    struct DPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DPS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DPS>(arg0, b"DPS", b"DolPhin Shower", b"for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdvzQTFP9LSxFoq2rjFwDm4htqgn2hafGy7vCG2xUb3Zv")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d82c7905c18745ebbadfe359b90614871487687d1a892490b9210a2eb50cf41a56b2803d9d2bc9085b2976cfa8652073bda018c3ee0250fc119a454261f7f60ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748187609"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

