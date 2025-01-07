module 0x5cfd8b2f1f10244d33373b07ce5b059ef5cb7af74b14d2f8dacf865775e50605::wow {
    struct WOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW>(arg0, 6, b"wow", b"wow", b"wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQcYx6XHXSg9tPncEtHH6rJc9PkDhPTdBZQnUgd8rLUVT")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<WOW>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<WOW>(13563598574985474365, v0, v1, 0x1::string::utf8(b"https://x.com/wow"), 0x1::string::utf8(b"https://wow.xyz/"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

