module 0x20883dfae09b5dd4a5433a1207bdd9fa945c9be8da24ae64f8af4145ca9af0e6::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"$REX", b"Suirex", b"Hop like Rex. Rex like Hop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdHT3ngjCqfn7wq8n668cnrqkaJ8YFQwt5GAghiQ9STuq")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<REX>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<REX>(12004502028118222607, v0, v1, 0x1::string::utf8(b"https://x.com/suirex_"), 0x1::string::utf8(b"https://suirex.xyz/"), 0x1::string::utf8(b"https://t.me/suirexannouncements"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

