module 0x89b232c474d991227d8ba6556c92fe0985907259d31036a79ba2a981602d98a8::xmh_baby {
    struct XMH_BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMH_BABY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<XMH_BABY>(arg0, 11721865807255292811, b"xmh", b"xmh baby", x"496e206d656d6f7279206f66206d7920786d6820626162792c20492077696c6c2072656d656d62657220697420666f726576657221204c6574e2809973206c6f7665206361747320746f67657468657221", b"https://images.hop.ag/ipfs/QmQs6VuxHA1Yk3njbrnf1L5NJKqyhJWqGtucQcEiXxHMsy", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

