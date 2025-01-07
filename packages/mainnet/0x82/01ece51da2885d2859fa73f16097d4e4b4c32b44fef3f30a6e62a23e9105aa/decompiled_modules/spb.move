module 0x8201ece51da2885d2859fa73f16097d4e4b4c32b44fef3f30a6e62a23e9105aa::spb {
    struct SPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SPB>(arg0, 7596078099480033691, b"spunk bubble", b"spb", b"the bubble will pop when we hit million market cap", b"https://images.hop.ag/ipfs/QmW81sndkxkEq6mfd9siiGpXSy1H95bKqH4Jz4a4ksowLb", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

