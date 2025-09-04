module 0xbd55b3f93df039b6631dea51237b618ca7e6b2983da3365bf99e3fc456a4a176::btx {
    struct BTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<BTX>(arg0, b"BTX", b"Bethoven", b"BethovenBethovenBethovenBethovenBethovenBethoven Bethoven Bethoven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdTKooyHyGYrZigFr4cxLATjL6MEvuwnWEsNt4LCEyZ3g")), b"https://en.wikipedia.org/wiki/Ludwig_van_Beethoven", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00fc2af3091ac70123a447809ca10455abad643a9a5fba9cfed959253528c926377e9a348d9ae66d0d88074859a313d97343bdddbf6d0e6b1136de3a24c72eed02d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1756996557"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

