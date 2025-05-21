module 0xc9ed4bb4c337c62912444eba4616e9877ae7109288c49884005a26f89baf387a::sharkui {
    struct SHARKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHARKUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHARKUI>(arg0, b"SHARKUI", b"SharKui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d467c70138f0433fcc91917171b5f56a5f719c33f084b456c1b459a4d9efbbcef1c494557c4cd1e7ab7bc8651933c3e05769f24ce75077968bf8328e479d4405d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747802141"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

