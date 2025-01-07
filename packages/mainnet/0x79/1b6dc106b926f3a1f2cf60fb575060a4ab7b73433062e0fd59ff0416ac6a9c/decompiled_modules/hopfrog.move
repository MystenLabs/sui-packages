module 0x791b6dc106b926f3a1f2cf60fb575060a4ab7b73433062e0fd59ff0416ac6a9c::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 13514167988605358333, b"HopFrog", b"HopFrog", b"First Frog on Hop Fun (@HopAggregator)", b"https://images.hop.ag/ipfs/QmaBoHMUVztbgy8nsE58VgXKGohYE6MuBDnhxg6kJePouU", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

