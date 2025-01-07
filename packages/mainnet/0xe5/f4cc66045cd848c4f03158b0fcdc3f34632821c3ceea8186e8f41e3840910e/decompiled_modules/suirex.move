module 0xe5f4cc66045cd848c4f03158b0fcdc3f34632821c3ceea8186e8f41e3840910e::suirex {
    struct SUIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREX>(arg0, 6, b"suirex", b"$REX", x"e2809c73752d72c99b6b73e2809d2e20536f6d657468696e672062696720616e6420626c756520697320636f6d696e67206578636c75736976656c7920746f200a40686f7061676772656761746f720a2e2049e280996d205265782c207765e28099726520616c6c20526578e280a62e20747261646520524558207573696e67206d6f6f6e6c697465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdHT3ngjCqfn7wq8n668cnrqkaJ8YFQwt5GAghiQ9STuq")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIREX>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIREX>(2993978781988537721, v0, v1, 0x1::string::utf8(b"https://x.com/suirex_"), 0x1::string::utf8(b"https://suirex.xyz"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

