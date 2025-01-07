module 0x490d8380bd87b1370c48aae57f5334334060f27f8824cb6ff6a3de2f8ff6db07::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 12525053283785390885, b"HopFrogSui", b"HOPFROG", b"0x05600ae1ba0b1ad37004fc5d45ff85d6705f2296ce023c554416ccfc0d0a5528", b"https://images.hop.ag/ipfs/QmfWL1NMzgFkfNqx21bUfJxWaZyqigkykvsSv9MYDGNvPE", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

