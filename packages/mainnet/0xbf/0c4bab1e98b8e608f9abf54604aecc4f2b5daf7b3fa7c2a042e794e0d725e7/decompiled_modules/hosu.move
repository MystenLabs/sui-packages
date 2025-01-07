module 0xbf0c4bab1e98b8e608f9abf54604aecc4f2b5daf7b3fa7c2a042e794e0d725e7::hosu {
    struct HOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOSU>(arg0, 6, b"HOSU", b"HOSU", x"484f50205820535549203d2024484f5355f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmVrHtwSLeNZB7oWKVqtwMMEunGcgkTwFCeEhbfWZPrD26")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOSU>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOSU>(17708365833224359274, v0, v1, 0x1::string::utf8(b"https://x.com/hosu_sui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

