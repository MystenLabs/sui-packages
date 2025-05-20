module 0x29ded818f439c89d2334b4a6bab536e7f56ba0e43d670ec74b0d678ebadaebb7::pkm {
    struct PKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PKM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PKM>(arg0, b"Pkm", b"Pokemon", b"pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcxHSYH4trYjmbeXuKRtGWRUAG1Kzdv43qvPiGqgBurSA")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ddca8ff6d1e6ab08a315e7389e2327f0e2f8ce7d4383e76300152c5ba304bf0b5f3244620153cc2db1ec77a75f62514b86da645ccfd48b51c4e9cf8b775b830dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747762570"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

