module 0x4b91de2b2cb2ee7ea9c673680c78a0ca452a154283badd485bfd9ccea25e585a::hep {
    struct HEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEP>(arg0, 6, b"Hep", b"Hep", b"0x43e9045850072b10168c565ca7c57060a420015343023a49e87e6e47d3a74231%3A%3Ahoppy%3A%3AHOPPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTiWn4JR3nJGz7P2FhJBQW1B6A3NMy8KeSxmE857dnRJK")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HEP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HEP>(758094510241326090, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

