module 0x6c402929926f865358e7e0f0966998955c41f9fc4d52912eb012ed0df223484d::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 10230984874679568291, b"Hop Frog On Sui", b"HOPFROG", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmUzCjR25CJMkj3U7vhppnASTUxntTayYC6JoFVtpvEPX1", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

