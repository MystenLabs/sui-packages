module 0xa6edacb6be27971d8dc2b846139859eb5357ad6f30d75b8566eb71982b4fd014::bct {
    struct BCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BCT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BCT>(arg0, b"BCT", b"bcryptoes", b"first on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNTkxQ8ePmZB9dg77eBJ5xBQo7Tpcv9kHEoEfYcJrHWT5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00889cbda072f57c18d3e099de8e7e03a817ee9ae7379ba1012cb6cec0aaced4b7a2245d7ccef61c1e415d28e7e58c9e18a35d62f612b3d91cc535f74c083e8a08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748182831"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

