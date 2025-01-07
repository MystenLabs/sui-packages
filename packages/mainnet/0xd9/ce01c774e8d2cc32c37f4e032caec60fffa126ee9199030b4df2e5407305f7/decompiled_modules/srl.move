module 0xd9ce01c774e8d2cc32c37f4e032caec60fffa126ee9199030b4df2e5407305f7::srl {
    struct SRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRL>(arg0, 6, b"SRL", b"Suirrel", b"Suirrel SUI MASCOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWNT3jGjZFRsz7ipsNyX8gwtptujcwaxgqde2yG5RsWCo")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SRL>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SRL>(3509721178971652705, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

