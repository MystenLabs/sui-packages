module 0xce171c22a27b5135f3a6aaee1ad7f46c64c45f19faa2360329531fea7b4d02ac::lwif {
    struct LWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWIF, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LWIF>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LWIF>(arg0, b"LWIF", b"lofiwifhat", b"testing the pad, not a real launch dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTEwE6MVpjPiTTMsMjbdVkAwYtY26DZiu6nWCquuweZD5")), b"www.wifhat.com", b"https://x.com/lofiwif", b"DISCORD", b"t.me/lofitest", 0x1::string::utf8(b"00c0c461e0547622ac2cd623650a4556af5a45124d049732c9af29ee5175b7e7fa84f4bf5e72dc3b57156afc7acda0a59b3fdf5d501fabbadb964b03f717f73e0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747800937"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

