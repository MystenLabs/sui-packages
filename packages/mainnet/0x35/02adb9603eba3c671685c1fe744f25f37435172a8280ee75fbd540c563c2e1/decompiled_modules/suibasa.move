module 0x3502adb9603eba3c671685c1fe744f25f37435172a8280ee75fbd540c563c2e1::suibasa {
    struct SUIBASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIBASA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIBASA>(arg0, b"SUIBASA", b"Suibasaur", b"The fist Pokemon on Splash!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYAjACTnLtfoh2SYruR7hGBRLAS9eKyJNzt58cnFx54Pu")), b"https://splash.xyz/", b"https://x.com/suibasaur", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00acfb7101e60bba0753a2a9f33a652ed8675e14ef543ac67d16ab11b6b114b0009efb0742dddb0507c0786354b2e20db2370487f2b35fd6f9241e9578a5b44a0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757317"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

