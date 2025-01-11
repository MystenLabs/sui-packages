module 0xfd8c6a5cb692dd20a35762c3d829e15afc74d1683077aba964dfdfd7d18c7958::nfa {
    struct NFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NFA>(arg0, 17544998635354144092, b"Not financial Advice", b"NFA", b"Try your luck", b"https://images.hop.ag/ipfs/QmQjqrhsQWhiTdWg4RzXj4KwbzZPbeCtsTUsD53Ucd3WFA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

