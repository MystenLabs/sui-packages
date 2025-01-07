module 0xf3fb3b0a13e5ded59137c5dee5209ac6c0b16f3e54303af7e360b5554a22625f::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPPY>(arg0, 1063493397663866368, b"HOPPY", b"Hoppy", x"486170707920486f70707920526162626974206f6e20235375696e6574776f726b0a416e20696d6d6f7274616c206a617966756c20726162626974206272696e67696e672053554920737a6e206261636b206f6e20747261636b2e", b"https://images.hop.ag/ipfs/QmcGCs5QXm3U1zL2iaTn5dULMEyQdHqNVcXH52UXjnskuB", 0x1::string::utf8(b"https://x.com/HoppyOnSui_X"), 0x1::string::utf8(b"https://hoppyonsui.xyz/"), 0x1::string::utf8(b"https://t.me/Hoppyonsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

