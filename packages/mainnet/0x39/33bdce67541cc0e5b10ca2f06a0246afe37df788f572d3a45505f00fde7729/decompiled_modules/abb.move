module 0x3933bdce67541cc0e5b10ca2f06a0246afe37df788f572d3a45505f00fde7729::abb {
    struct ABB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ABB>(arg0, 5157160994625569137, b"Aboba", b"ABB", x"d0abd0abd0abd0abd0abd0abd0abd0ab", b"https://images.hop.ag/ipfs/QmfCduq4BnHRRpqM431LU1usBTr1Xb21WJNCFWvPMHSGNo", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

