module 0xa687b7d54c269547ffc47a0196669e5ec4726588512a01700bf9f41dc9a2d9e8::rmos {
    struct RMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMOS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RMOS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RMOS>(arg0, b"RMOS", b"RICH MAN ON SUI", b"Rich man on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQT5VTAu3GxLgyEjskEpe9yakPvB1wcpAMZR1rNx8bNLb")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0010e79d4ff091c98c211ca7c514a5ae52b5a3ff2e8758a4849b1a3710f6b4b4a3b261a171ff5c8bcfbda8c0b03fef061fba2e859d5b34f04de0de7e6db159e30dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748062824"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

