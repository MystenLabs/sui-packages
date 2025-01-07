module 0xdbe182cd32dd40ee1abb7786fa4797ce3b758ac260c8b9ecf17576bee7ce84c3::fartduck {
    struct FARTDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FARTDUCK>(arg0, 15424513104741970432, b"FARTDUCK", b"FARTDUCK", x"f09f90a420464152544455434b20f09f90a40af09f9a8020544845204d4f53542042554c4c4953482046415254494e47204455434b20494e2043525950544f20535041434520544841542057494c4c204252494e4720594f5520544f20544845204d4f4f4e2120f09f8c95", b"https://images.hop.ag/ipfs/QmWUuEoJiJMJm6Ly7taTbCjpzXArSpfMmGPrV3zvHUCEx8", 0x1::string::utf8(b"https://x.com/FartDuck2024"), 0x1::string::utf8(b"https://fartduck.xyz/"), 0x1::string::utf8(b"https://t.me/FartDuck_SUI"), arg1);
    }

    // decompiled from Move bytecode v6
}

