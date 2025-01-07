module 0x10eaedd61b0b4c73084cf60012d5637ec8591b98fe1e1bf770cd52e50169574e::suiq {
    struct SUIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQ, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIQ>(arg0, 17415601080597494015, b"Suiqrrel", b"SUIQ", x"4865792068656c6c6f212049276d2074686520666972737420616e64206f6e6c7920737175697272656c20696e20746865200a407375696e6574776f726b2e20416e642049206e656564207065616e75747320f09fa59c", b"https://images.hop.ag/ipfs/QmNdKV5RqQUbszriCVin7wuLPDHGJpV8YekBxkCh6KnGr7", 0x1::string::utf8(b"https://x.com/suiqrrel"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

