module 0x1de2b217167ab938ffd90692d9829273a080f035a5a27483ee12035691b85b8::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOG>(arg0, 6, b"HOPDOG", b"HOPDOG", b"Doogy, The Hopper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQcWxSv4KMRKz5uhZgGAuiB3iK6VKcTio9r1wzAiaZk99")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPDOG>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPDOG>(15586662153675505355, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

