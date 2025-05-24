module 0x718e565e5cf48ac88278348f2b7f3809953b57b4fac9edf86249c898707ac82::raider {
    struct RAIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIDER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RAIDER>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RAIDER>(arg0, b"Raider", b"Raider Guard", b"Symbol of your status as a knight in the world of MapleStory. Tokens represent you as a member of the mighty Raider Guard fighting against the forces of the Black Mage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYiMdRHqH9ccPu8pHq1cJ4sJHMMt5rXQZuGN2XRXsabEE")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004a0dc06735fe73e1e32e806898fa0adb79d50d0615245992e293c90b26c719adac8bee5255ac72b04826076cf725784d02ded2862fe39a6828ff03e43b05c60fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748080449"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

