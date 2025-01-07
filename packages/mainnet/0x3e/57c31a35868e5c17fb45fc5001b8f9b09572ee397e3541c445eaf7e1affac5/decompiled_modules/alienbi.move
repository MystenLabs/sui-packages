module 0x3e57c31a35868e5c17fb45fc5001b8f9b09572ee397e3541c445eaf7e1affac5::alienbi {
    struct ALIENBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIENBI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ALIENBI>(arg0, 12588468661104097638, b"Billion dollar baby allien", b"AlienBi", b"Let's help the baby reach the Moon", b"https://images.hop.ag/ipfs/QmT71owMRxzkLxsFTsRfeZsRcR61gn9fxZdp6mMdePvKCk", 0x1::string::utf8(b"https://x.com/xAlienbi"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/alienby"), arg1);
    }

    // decompiled from Move bytecode v6
}

