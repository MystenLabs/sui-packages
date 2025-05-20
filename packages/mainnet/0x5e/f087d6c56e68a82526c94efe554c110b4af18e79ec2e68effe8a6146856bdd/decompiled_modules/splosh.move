module 0x5ef087d6c56e68a82526c94efe554c110b4af18e79ec2e68effe8a6146856bdd::splosh {
    struct SPLOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLOSH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLOSH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLOSH>(arg0, b"SPLOSH", b"SPLOSH DOGI", b"and i am alien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRQNiWqEbcszw7udHSJzsACqc2Mx8qfk6CwgcPzriw4VX")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0030295970ae73d43b4ff3263b0e6ea645be6dadec64937b225127d397b956397582dc8b8e13a07fdc2530189a3705c5fb83b0d6dbc36cdbf850e76200745c200ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747767531"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

