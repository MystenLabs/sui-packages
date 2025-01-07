module 0x8c4f53e04025ac03fb692e23a11878185c50c7b7cc5f037f3a523c82b7aae866::basedai {
    struct BASEDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASEDAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BASEDAI>(arg0, 14052616910457202231, b"BasedAI", b"BasedAI", b"Beyond agents, beyond humans, there are creatures. Wake Up Neo...", b"https://images.hop.ag/ipfs/Qme1xjpD29h2Ftk4ehaTvJ96XYCgjjfoioP7SAsQ4nT2Vb", 0x1::string::utf8(b"https://x.com/getbasedai"), 0x1::string::utf8(b"https://www.getbased.ai/"), 0x1::string::utf8(b"https://t.me/getbasedai"), arg1);
    }

    // decompiled from Move bytecode v6
}

