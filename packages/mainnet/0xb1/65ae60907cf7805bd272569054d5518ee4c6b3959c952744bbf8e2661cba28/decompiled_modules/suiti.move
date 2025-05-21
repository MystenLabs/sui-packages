module 0xb165ae60907cf7805bd272569054d5518ee4c6b3959c952744bbf8e2661cba28::suiti {
    struct SUITI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUITI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUITI>(arg0, b"SUITI", b"Suiti Pokegun", x"53756974692069732074686520666972737420506f6bc3a96d6f6e2053686f6f74696e672067616d65206f6e20537569626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYGBhowTBfmcEoK73acoK39Fo1CHUdoxWRewmpUs6hgwm")), b"https://www.notion.so/Suitito-PokeGuns-SUITITO-Whitepaper-1f4be6f8ec5e80deb009fd5b46856674", b"https://x.com/SuititoPokegun", b"DISCORD", b"https://t.me/Suititopokegun", 0x1::string::utf8(b"00d7dbafc12cbff6063367bfc91ddbc123aaf6fa0d91f5f6eb141de800089c971050197cdd2d97e0fb20b7541f8caabc26acd99fc753d179b93ba9b46b05d39506d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747838562"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

