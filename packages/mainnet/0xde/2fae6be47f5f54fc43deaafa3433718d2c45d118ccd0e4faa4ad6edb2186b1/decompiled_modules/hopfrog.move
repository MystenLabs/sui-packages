module 0xde2fae6be47f5f54fc43deaafa3433718d2c45d118ccd0e4faa4ad6edb2186b1::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 4787989455568790886, b"Hop Frog On Sui", b"HOPFROG", b"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.\" Sun Tzu, The Art of War.", b"https://images.hop.ag/ipfs/QmUzCjR25CJMkj3U7vhppnASTUxntTayYC6JoFVtpvEPX1", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

