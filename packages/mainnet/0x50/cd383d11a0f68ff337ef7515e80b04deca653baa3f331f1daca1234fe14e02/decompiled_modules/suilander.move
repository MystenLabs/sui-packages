module 0x50cd383d11a0f68ff337ef7515e80b04deca653baa3f331f1daca1234fe14e02::suilander {
    struct SUILANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANDER>(arg0, 6, b"SUILANDER", b"SuiLander", x"4c616e6465722066616d696c79206973206172726976696e6720746f20535549206e6574776f726b2e2e2e6d656574c2a027656dc2a0616c6c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmRLjAX2Fdue4K95hT6EBpBwMpZHZx5qP77upYS9K9W6Ci")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUILANDER>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUILANDER>(14707790087447106315, v0, v1, 0x1::string::utf8(b"https://x.com/suilanderfun"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

