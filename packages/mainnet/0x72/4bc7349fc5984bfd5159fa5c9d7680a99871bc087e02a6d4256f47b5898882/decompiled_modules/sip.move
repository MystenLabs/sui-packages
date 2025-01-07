module 0x724bc7349fc5984bfd5159fa5c9d7680a99871bc087e02a6d4256f47b5898882::sip {
    struct SIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIP>(arg0, 6, b"SIP", b"SUIPEPSI", b"SUI PEPSI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmaS9xVSRRUZAttHzzUmsy9rhnN6QD1v5QfbCpM3AR9Yas")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SIP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SIP>(11501723201410741470, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

