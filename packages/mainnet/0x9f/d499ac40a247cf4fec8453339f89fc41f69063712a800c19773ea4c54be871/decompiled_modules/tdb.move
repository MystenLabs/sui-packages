module 0x9fd499ac40a247cf4fec8453339f89fc41f69063712a800c19773ea4c54be871::tdb {
    struct TDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TDB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TDB>(arg0, b"TDB", b"Test only Do not Buy", b"Just a Test Token. Nothing Fancy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeX2ckr4BHYphgdRnRxiBkWPdhJX2XcmP25MDwshaeN2W")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00486ba29d4feead6f49b0e225fb396d0028bfeea729dbc97acaa66ffcc4dd6e72c554debf0193608bd9d8f3d7f5d46d0476ac1f81fe709170bcf649a1058e360ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748109229"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

