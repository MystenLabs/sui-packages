module 0xb94a137bcdadc06d728962dbb6fde4e3a7d7802a4a33c330cfc7f23c33c62460::dogg {
    struct DOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DOGG>(arg0, 17777446029973147338, b"TATESDOGG", b"DOGG", x"48656c6c6f2065766572796f6e6521204920616d20472c20416e6472657720616e64205472697374616ec2b47320646f672e20492065617420676f6f64206d65616c7320616e642070726f7465637420746865207375706572636172732e", b"https://images.hop.ag/ipfs/QmfPybEz9aSByKRXjphjUmHttxKBNEj9Zo2HNsmBZqwopZ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

