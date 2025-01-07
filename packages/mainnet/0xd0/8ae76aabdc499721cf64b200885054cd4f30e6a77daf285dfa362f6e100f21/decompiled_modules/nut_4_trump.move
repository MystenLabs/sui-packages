module 0xd08ae76aabdc499721cf64b200885054cd4f30e6a77daf285dfa362f6e100f21::nut_4_trump {
    struct NUT_4_TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUT_4_TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUT_4_TRUMP>(arg0, 6, b"Nut4Trump", b"Nut4Trump", b"Nut4Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmd1PepZLWW7pLiHxNgHhHBU2Me35Bkh7sueumZfLLYYcL")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<NUT_4_TRUMP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<NUT_4_TRUMP>(11810826308749840464, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

