module 0x4838867fe2748b20078101276d6cf5d80c2c9f6da794fae5eb6bca5a134ca739::hush {
    struct HUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HUSH>(arg0, 11743091109433672634, b"HUSH MONEY", b"HUSH", b"Inspired by recent political events involving Donald Trump, particularly related to legal issues colloquially known as \"hush money\" cases. This coin embodies the theme of silence, secrecy, or the attempt to keep things under wraps.", b"https://images.hop.ag/ipfs/QmQU5gH19voi1Udqy6rVxRnLBZJaLy3td4dMwG8tz9dGDD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

