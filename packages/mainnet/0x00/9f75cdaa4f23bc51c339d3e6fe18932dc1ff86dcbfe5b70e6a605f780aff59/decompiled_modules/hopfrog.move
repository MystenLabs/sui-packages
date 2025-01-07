module 0x9f75cdaa4f23bc51c339d3e6fe18932dc1ff86dcbfe5b70e6a605f780aff59::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 15919053353064733125, b"Hop Frog On Sui", b"HOPFROG", b"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.", b"https://images.hop.ag/ipfs/Qmdr1Qzv54Zs4eKkyYQtQdeTfDi4ekhdkhz83YXJsmtdMv", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

