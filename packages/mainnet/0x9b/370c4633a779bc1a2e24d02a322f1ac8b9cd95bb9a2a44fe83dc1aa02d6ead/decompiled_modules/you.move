module 0x9b370c4633a779bc1a2e24d02a322f1ac8b9cd95bb9a2a44fe83dc1aa02d6ead::you {
    struct YOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<YOU>(arg0, 3093002396358990064, b"YouSUI", b"You", b"All-In-One Platform in #SuiNetwork", b"https://images.hop.ag/ipfs/QmUGuMoBN6EBNTtt91ED1XuKVFkfJ55Ywa4aiozrrGq4rY", 0x1::string::utf8(b"https://x.com/YouSUI_Global"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

