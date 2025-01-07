module 0x42d373163f9e4caa762bbb83350ae581b5781aa7bd27c34345455b2b2758db0c::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 6, b"wDOG", b"wrapped dog", b">>>.<<", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmVAQDZHkqzaWotRwut3fjw1WAgRByiyqPVFMdWExzFExy")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<WDOG>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<WDOG>(8033072861455564440, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

