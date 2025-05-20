module 0xf1ae76f7c3ad8cd198ae104b363c98f32d970d84b5a023c9242d889133cf2672::suiri {
    struct SUIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIRI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIRI>(arg0, b"SUIRI", b"Suiri Drippy Water", b"Suiri is a drippy water from Sui Blockchain, curious and ready to vibe. Let's goo explore!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXJ5AYXYvb3pyTG4bCNKejpbmDY1yrNUhxWRtWzRYhR7h")), b"https://www.suiri.fun/", b"https://x.com/SuiriOnSui", b"DISCORD", b"https://t.me/SuiriOnSui", 0x1::string::utf8(b"00491acdf3b85f68afa9d3de5680046e331359613f353527e594dff7ae1ad031656ac3ce6b6bbcaea2f962059b6d2e0aee517d86b6fff3997772a0e8a3f0103000d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759508"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

