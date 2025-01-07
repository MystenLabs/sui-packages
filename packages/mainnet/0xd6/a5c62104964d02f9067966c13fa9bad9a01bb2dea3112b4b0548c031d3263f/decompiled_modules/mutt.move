module 0xd6a5c62104964d02f9067966c13fa9bad9a01bb2dea3112b4b0548c031d3263f::mutt {
    struct MUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTT>(arg0, 6, b"MUTT", b"Mutt Coin", x"4d75747420436f696e206f6e2053756920626563617573652065766572797468696e672062657474657220776974682061204d75747420f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPoUkTqLhdZSVsV1FpUFaUPYVFPNyUcV6TSMdRr4Z2Hut")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MUTT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MUTT>(5949202760943061916, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

