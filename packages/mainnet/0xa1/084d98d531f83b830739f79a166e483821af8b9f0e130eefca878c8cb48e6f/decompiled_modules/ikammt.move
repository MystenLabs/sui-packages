module 0xa1084d98d531f83b830739f79a166e483821af8b9f0e130eefca878c8cb48e6f::ikammt {
    struct IKAMMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKAMMT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<IKAMMT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<IKAMMT>(arg0, b"IKAMMT", b"IkaMMT", x"546865206c6974746c65206775792077617320746f6f20637574652e20f09fa69120496b612078204d6f6d656e74756d2046414e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNfvEeuTVgZjbrKxvffqiga8R6LpP7Xz5z3b6yKs3smLn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00413d17621e6c83c7c956db8951b20a0626fcc126efec7c6d79604396f5c4453bf4d86e1f531b3d3a88f6215318d14f401b81309cd81519e47e7fe7bb09ecd202d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748100090"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

