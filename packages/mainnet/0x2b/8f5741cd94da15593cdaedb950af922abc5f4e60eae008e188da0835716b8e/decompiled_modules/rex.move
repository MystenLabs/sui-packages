module 0x2b8f5741cd94da15593cdaedb950af922abc5f4e60eae008e188da0835716b8e::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"suirex", b"RREX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYdBcFuBEcfycWePmayw4Tb3fwDa11GXYY389MNTpmh8P")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<REX>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<REX>(99735627813372667, v0, v1, 0x1::string::utf8(b"https://x.com/suirex_"), 0x1::string::utf8(b"https://suirex.xyz/"), 0x1::string::utf8(b"https://t.me/suirexannouncements"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

