module 0x85ca91596e9dd2722fd70886551ea58116cd8c7bb1e1b7a50c7ecef0db9e0245::sewey {
    struct SEWEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWEY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SEWEY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SEWEY>(arg0, b"Sewey", b"IShowSpeed", b"suiiiiiiiiiiiiiiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb6trvayTiwgpv9Ze6XJreVDU4eU1cAizjdJewti8AELN")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ce9ea3d640aff1e22a29d6c4e1a136642427ec7316f1164b920023cbad5cae439b89fd0492a7dec3bf8b48a885f5d8e21075ae40494afe3f63f57fcdd1d0540dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747774291"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

