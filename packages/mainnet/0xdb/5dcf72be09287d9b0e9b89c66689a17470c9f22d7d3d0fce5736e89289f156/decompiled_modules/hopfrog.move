module 0xdb5dcf72be09287d9b0e9b89c66689a17470c9f22d7d3d0fce5736e89289f156::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 14453087515170942211, b"Hop Frog On Sui", b"HOPFROG", b"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win. Sun Tzu, The Art of War.", b"https://images.hop.ag/ipfs/QmUzCjR25CJMkj3U7vhppnASTUxntTayYC6JoFVtpvEPX1", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

