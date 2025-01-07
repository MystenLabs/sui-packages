module 0x49265d05f2d2fcd5fd1c10656e044e26028c576f3fc6c937f7fdc5b7d17616ea::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 14038688896652923976, b"HopFrogSui", b"HopFrog", b"First Frog on HopFun. A ninja's path is one perseverance, and it requires a mindset that thrives in isolation. Being alone doesn't scare us.", b"https://images.hop.ag/ipfs/QmQttAN93HWXgjrLBBUa8tZAxdgmppQZYSTi99FRibTBfT", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

