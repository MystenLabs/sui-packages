module 0x124abc390c111053f7888ad4189651516f64b014eacd9227cf3a5041777603f8::yl {
    struct YL has drop {
        dummy_field: bool,
    }

    fun init(arg0: YL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<YL>(arg0, 4232891181405702840, b"YAGAMI LIGHT", b"YL", b"KIRA", b"https://images.hop.ag/ipfs/QmSqprrgMYAUv7Kd9nGxdLz4cBHDmBxFS9rsd373a8gvwP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

