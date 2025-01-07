module 0x6187f8506f3a0f7aa95190fedbdc6a79b55e34921fba07bfca165d920489f718::kitty {
    struct KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTY>(arg0, 6, b"Kitty", b"KittyCat", b"The cutest Kitty Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPNf7yRRH3tRysSe3r3teM6P64USuk9LPbq523xiihR29")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<KITTY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<KITTY>(1823223599140643311, v0, v1, 0x1::string::utf8(b"https://x.com/CatCareCorner"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

