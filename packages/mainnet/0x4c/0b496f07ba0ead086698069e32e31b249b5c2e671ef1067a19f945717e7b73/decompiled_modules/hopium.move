module 0x4c0b496f07ba0ead086698069e32e31b249b5c2e671ef1067a19f945717e7b73::hopium {
    struct HOPIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPIUM>(arg0, 6, b"hopium", b"hopium", b"hopium!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTqZ1Kw82amoD575LSGhVf5sXtdpYhxs7HrBDV96Ld249")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPIUM>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPIUM>(6526810588489617653, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://en.m.wikipedia.org/wiki/Hopium"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

