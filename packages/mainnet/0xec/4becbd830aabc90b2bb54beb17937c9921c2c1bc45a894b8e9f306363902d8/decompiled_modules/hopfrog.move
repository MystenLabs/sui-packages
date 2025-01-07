module 0xec4becbd830aabc90b2bb54beb17937c9921c2c1bc45a894b8e9f306363902d8::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 2174372957497149723, b"The Hop Frog", b"HOPFROG", x"41206e696e6a61e28099732070617468206973206f6e65206f66207065727365766572616e63652c20616e642069742072657175697265732061206d696e647365742074686174207468726976657320696e2069736f6c6174696f6e2e0a486f7046726f672c206e6f77206f6e205355492e", b"https://images.hop.ag/ipfs/QmXmmpgWbSniRVV4e7cgUgfxanjsTojqvFTp1HKSPKTZfe", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://t.co/OHQecoSeN7"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

