module 0x4fd751ad6d16f286e23ec0843987784d27b180c67807355ca4fa062a7eda2ef7::dscv {
    struct DSCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSCV, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DSCV>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DSCV>(arg0, b"DSCV", b"DeSci Metaverse", b"Bridging in Science, AI, & MetaVerse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmV9MbJ5RYYR2BBo7NguEQQfP5UNR1doFyfkiMM6x78No8")), b"https://desciverse.tech/", b"https://x.com/desciverse_", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00dac72fbaf7af22e819a589dcb575f0a2e9e7064f9fb69919976a5a9e464f27b7509726389706851673476d4b969673c0be4e35cd37b71b77e69885b6895dd903d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747775605"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

