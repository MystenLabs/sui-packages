module 0xf67d1813a515459cd66ca37d1bda631eb47e1c7f45918a4b68ebc4f1c356d220::suiti {
    struct SUITI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUITI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUITI>(arg0, b"SUITI", b"Suiti Pokemon Game", x"53756974692069732074686520666972737420506f6bc3a96d6f6e20616374696f6e2067616d65206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYGBhowTBfmcEoK73acoK39Fo1CHUdoxWRewmpUs6hgwm")), b"https://www.notion.so/Suitito-PokeGuns-SUITITO-Whitepaper-1f4be6f8ec5e80deb009fd5b46856674", b"https://x.com/SuititoPokegun", b"DISCORD", b"https://t.me/Suititopokegun", 0x1::string::utf8(b"0059fb93adb7fbb50c45089f5da638e74059b3b9a3b80be475b99927181183254ba310859c8c15ffc287ae87fe802857c2552fb8b2a6a157b1d6df2e5b93c95a06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747839083"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

