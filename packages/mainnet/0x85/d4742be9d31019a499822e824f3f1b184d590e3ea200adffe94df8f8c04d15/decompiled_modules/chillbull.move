module 0x85d4742be9d31019a499822e824f3f1b184d590e3ea200adffe94df8f8c04d15::chillbull {
    struct CHILLBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBULL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CHILLBULL>(arg0, 11146376192881361240, b"The Chill Bull", b"ChillBull", b"The only Chill Bull on Sui!", b"https://images.hop.ag/ipfs/QmfZTkGLfC1C2oxjFS36SZp1QzrgCxuQYMNJ8nULtLPwLL", 0x1::string::utf8(b"https://x.com/thechillbull"), 0x1::string::utf8(b"https://www.chillbull.fun/"), 0x1::string::utf8(b"https://t.me/ChillBullSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

