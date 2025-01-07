module 0x743bb4daab7da0236145c9079e4e2995bdf0cb3ed45d542d9a2add57bb820895::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 5483528810812881116, b"HopFrogSui", b"HOPFROG", b"Ofiicial Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmYe6GASmwFG4Aa2sm82mpuFtGMmgjz5Sex2hiBf2wcMbr", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

