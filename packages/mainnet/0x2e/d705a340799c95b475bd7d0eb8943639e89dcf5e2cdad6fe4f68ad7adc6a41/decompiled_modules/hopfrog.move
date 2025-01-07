module 0x2ed705a340799c95b475bd7d0eb8943639e89dcf5e2cdad6fe4f68ad7adc6a41::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 1977771003839492054, b"HopFrogSui", b"HopFrog", b"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win.\" Sun Tzu, The Art of War.", b"https://images.hop.ag/ipfs/QmeBvJLiKpydNp9PdAavxAP5UBBqZ51GEBt7VwfVvxi82A", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

