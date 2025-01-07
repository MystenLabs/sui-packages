module 0xfa2dbc9f82f0135b35eb67e60136552f9d767f23847aa33e1c88263a6702629::bc {
    struct BC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BC, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BC>(arg0, 5905840554867966864, b"BREAD CAT", b"BC", b"MEOW", b"https://images.hop.ag/ipfs/QmSqprrgMYAUv7Kd9nGxdLz4cBHDmBxFS9rsd373a8gvwP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

