module 0xe300dd5a63077e1ee302b8cb1f5ef1676a1ce45e21fefa3e54e38764df66dc8a::yarra {
    struct YARRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YARRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YARRA>(arg0, 6, b"YARRA", b"YARRAAA", b"YARRRAAAAAAAAAAAA YARRRAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmP9GZWakzUY6sGazfQBwXoEJT4FAousRpL1RjpGoCYxiB")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<YARRA>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<YARRA>(13782662685034266913, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

