module 0xa862f2fa721e0a5c4ef7ecc086088c045e9bf246acfcebf97f6b95bb8c16eea7::krabs {
    struct KRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<KRABS>(arg0, 14734950015299117598, b"MR. Krabs", b"KRABS", x"4e6f20636f6d6d756e6974792c204e6f2061697264726f702c204e6f20736f6369616c732e0a0a4a757374204d6f6e65792e204a75737420636173696e6f2e0a0a417065206561726c7920616e642062652072696368", b"https://images.hop.ag/ipfs/Qmb83QLPhdKFvUkQGN7ZoWjtxxLeu8wZsQK7w98LLqttxU", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

