module 0x9576e312c086384fbd5ad0ddc5ed6a8bf5e4d6d645604d2994c4b5e52e127815::hfrog {
    struct HFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HFROG>(arg0, 7055103805928306385, b"HopFrogSui", b"HFROG", b"Quick, silent, and deadly. A master of stealth, ready to strike when least expected.", b"https://images.hop.ag/ipfs/QmeBvJLiKpydNp9PdAavxAP5UBBqZ51GEBt7VwfVvxi82A", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

