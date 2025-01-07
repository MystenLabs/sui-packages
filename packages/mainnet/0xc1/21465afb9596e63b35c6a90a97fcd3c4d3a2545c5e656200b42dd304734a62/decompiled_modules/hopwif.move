module 0xc121465afb9596e63b35c6a90a97fcd3c4d3a2545c5e656200b42dd304734a62::hopwif {
    struct HOPWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPWIF>(arg0, 6, b"HOPWIF", b"HOP WIF", b"hop wif token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQvXjD3avEQMvYHXK9qGPA4ixefgNqQXLfyd5PiLz3y35")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPWIF>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPWIF>(13105964829111168989, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

