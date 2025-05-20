module 0xbc437ecc43f05fac64a23c73556cf32f74049c8f8a2e52c223deb3eae480c12a::h2o {
    struct H2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2O, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<H2O>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<H2O>(arg0, b"H2o", b"H2O", b"Water (H2O) is a polar inorganic compound that is at room temperature a tasteless and odorless liquid, which is nearly colorless apart from an inherent hint of blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfXy1pWN877fvGiB5XoMy96ARMNX17gekaTkXmnChM1tK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006c741a1b827ac415094b44962d804aab18d8ee935c8093eb275711160fa29aa55ead3a73990b153112a2ec62548ab56cb154dd7119f3baf2163d3672b8949a0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759251"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

