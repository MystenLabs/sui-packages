module 0xc01d494aa6049ed87c5f7f2b81b9525446ad9a63c7bfd95d68bc8188a629190::era {
    struct ERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERA>(arg0, 6, b"ERA", b"SUI ERA", b"This token only for FUN sui Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmcayForoZDr6vagigwmag9nUmUhaM33qBJVngjdLb4j5v")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<ERA>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<ERA>(16603187565891087641, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

