module 0xa8debf9f3ea3d26903f7f3351d0b92e2958ef75948e712e3ad30adc7fd5474e3::kenobi {
    struct KENOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENOBI>(arg0, 6, b"Kenobi", b"Kenobi", b"SUI First Kenobi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmP1pNBdQPGzrbyN4wUuqzSWurVGJgxhkw1KpTnsMvwGUb")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<KENOBI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<KENOBI>(10715456099422523452, v0, v1, 0x1::string::utf8(b"https://x.com/elonmusk/status/1852745739379658774"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

