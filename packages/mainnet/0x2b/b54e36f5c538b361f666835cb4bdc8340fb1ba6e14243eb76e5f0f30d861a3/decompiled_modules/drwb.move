module 0x2bb54e36f5c538b361f666835cb4bdc8340fb1ba6e14243eb76e5f0f30d861a3::drwb {
    struct DRWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRWB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DRWB>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DRWB>(arg0, b"DRWB", b"Doraemon with Bomb", b"Doraemon with bomb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWAown6VgqCvDTB72ETyxNDo9rkGdv65acSJdCjWTfH5v")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f695f60784051a1a2668e88e5974885ea1f73cf38e6cfc69945dd6e22eee39b8b2a920d3bbb6e208d08dd27e30a21111314602322b274584b777e2ed6a98a909d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747810935"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

