module 0x8394fd59130b598c82326ec0a50006af1a6ff2af1bf53af4613cbb72174afa21::stb {
    struct STB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<STB>(arg0, 8719599701555122566, b"Sell the Bottom", b"STB", b"ass always", b"https://images.hop.ag/ipfs/QmVQVeRHPbvGVLMAtP75ovqk1RMux16JjdLFkeCrEG8GCE", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

