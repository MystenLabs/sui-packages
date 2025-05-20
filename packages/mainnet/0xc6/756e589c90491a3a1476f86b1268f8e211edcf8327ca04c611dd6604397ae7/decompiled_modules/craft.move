module 0xc6756e589c90491a3a1476f86b1268f8e211edcf8327ca04c611dd6604397ae7::craft {
    struct CRAFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CRAFT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CRAFT>(arg0, b"CRAFT", b"Splash Craft", b"Let's $CRAFT - Creating the future in 3D. Powered by the @SuiNetwork Built with @Splash_xyz , owned by you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRmFc7dcBX7STGNCufDCKCTMzujbRd9j986Xx8WX1c8sw")), b"https://www.splashcraft.fun/", b"https://x.com/SplashCraft_", b"DISCORD", b"https://t.me/splash_craft", 0x1::string::utf8(b"00057695b36acb5b440b6b9ef41d0169495900e29c737571b2d30db0711e3de5ce927560f754ff06148a9fc8b02d5742c1405d06845ab62b59fc7ae0deb700c00ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759602"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

