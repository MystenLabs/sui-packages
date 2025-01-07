module 0x71f21ebf33eac29b52c6e24177d58a6b8283c6cee4f5ee50ef0f5fbdf986a962::gud {
    struct GUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUD>(arg0, 6, b"GUD", b"GUD COIN", b"DIS COIN IS GUD COIN. VERY GUD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSbyWJn388iyGLjvKbK2nBcXtqGevcZr6YHU2xLmeWuSa")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<GUD>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<GUD>(14065541310739945372, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

