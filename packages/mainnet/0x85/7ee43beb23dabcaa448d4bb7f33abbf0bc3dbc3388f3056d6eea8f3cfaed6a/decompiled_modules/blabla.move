module 0x857ee43beb23dabcaa448d4bb7f33abbf0bc3dbc3388f3056d6eea8f3cfaed6a::blabla {
    struct BLABLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLABLA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLABLA>(arg0, 2330137013766030268, b"blabla", b"blabla", b"blabla", b"https://images.hop.ag/ipfs/QmTGG5uGYNZioaJ9sEdfHq5AXPfLtbNdBYqE76oqP7jxVx", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

