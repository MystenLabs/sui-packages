module 0x12c106c50632268986c4632ae183574cd08a54c7b04456c3909d1d05b26b7122::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 5844529025032002537, b"HopFrog", b"HOPFROG", b"Victorious warriors win first and then go to war, while defeated warriors go to war first and then seek to win. Sun Tzu, The Art of War.", b"https://images.hop.ag/ipfs/QmUxugtFwfRN2WVLSW9BTrKqM9c6udo7bM7aU81NkhTcUr", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

