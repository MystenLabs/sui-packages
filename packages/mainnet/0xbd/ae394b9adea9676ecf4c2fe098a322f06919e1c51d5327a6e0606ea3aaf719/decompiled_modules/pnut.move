module 0xbdae394b9adea9676ecf4c2fe098a322f06919e1c51d5327a6e0606ea3aaf719::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"Pnut", b"Peanut the Squirrel", b"RIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQUAM2io5bgcf1LU8ocEhwnp11p318nPxrQQcNBXHPq2d")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PNUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PNUT>(6533309833496134672, v0, v1, 0x1::string::utf8(b"https://x.com/pnutsolana"), 0x1::string::utf8(b"https://www.change.org/p/call-for-justice-for-peanut-the-squirrel-and-nysdec-reform?fbclid=PAZXh0bgNhZW0CMTEAAaY5fhbirfmm3r9IKhUH_DM6ONraf0BqQwn0aeGC0-CliWxqrljBQ8rXI-w_aem_ntFZBEK60MKAtA8LG3oh6w"), 0x1::string::utf8(b"https://t.me/pnutportal"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

