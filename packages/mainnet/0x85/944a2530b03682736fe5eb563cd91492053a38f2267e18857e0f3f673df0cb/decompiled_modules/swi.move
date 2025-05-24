module 0x85944a2530b03682736fe5eb563cd91492053a38f2267e18857e0f3f673df0cb::swi {
    struct SWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SWI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SWI>(arg0, b"SWI", b"SUIWEI", b"WEI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVtYrQTSnyBjPHnQfd47Bfw6REkfziqotNWAmuP1asP8y")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000137b1c335b3192700620d498a945403d10fcd8401e45facfcfd2341d71e0408844bb5dd94fe4437c2a62d5ce1e24441f962ca6099ee266d53d24c716c4bab03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748086400"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

