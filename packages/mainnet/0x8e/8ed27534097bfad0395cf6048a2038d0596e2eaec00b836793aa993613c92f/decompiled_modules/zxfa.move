module 0x8e8ed27534097bfad0395cf6048a2038d0596e2eaec00b836793aa993613c92f::zxfa {
    struct ZXFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXFA>(arg0, 6, b"ZXFA", b"SFKSA", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbsPuRTycWmNLvRLthrkMMDY6r4DAAkX5vJM7rU55Y5RR")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<ZXFA>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<ZXFA>(11907853490897468644, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

