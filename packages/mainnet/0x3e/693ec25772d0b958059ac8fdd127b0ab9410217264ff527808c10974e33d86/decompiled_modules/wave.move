module 0x3e693ec25772d0b958059ac8fdd127b0ab9410217264ff527808c10974e33d86::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WAVE>(arg0, 13270700335408559257, b"WaveToken", b"WAVE", b"WaveToken (WAVE) is a cutting-edge digital asset built on the Sui Blockchain, designed to harness the power of seamless innovation and liquidity. Inspired by the natural flow and adaptability of waves, WaveToken embodies efficiency, fluidity, and resilience, making it an ideal solution for modern digital economies.", b"https://images.hop.ag/ipfs/QmQLeX3srBdQhqHW28Bv5cQzJy3kBuhikEuhqoeeWFL4yt", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

