module 0xcb72aa3e981829c1246fc42423a05acb855c07d79d06d9db6e1d89e4d841892a::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BANANA>(arg0, 18155796842763041829, b"Banana", b"BANANA", b"Literally just a banana", b"https://images.hop.ag/ipfs/QmciC1ikGsxc4sUZBkmZotR7bgTL9N2uudBr8kTkD7MEHw", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+9TR5fUbNsZk5NDRl"), arg1);
    }

    // decompiled from Move bytecode v6
}

