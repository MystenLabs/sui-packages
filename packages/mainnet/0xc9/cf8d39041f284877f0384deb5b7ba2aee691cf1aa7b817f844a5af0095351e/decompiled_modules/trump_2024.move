module 0xc9cf8d39041f284877f0384deb5b7ba2aee691cf1aa7b817f844a5af0095351e::trump_2024 {
    struct TRUMP_2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_2024>(arg0, 6, b"TRUMP2024", x"e29891205452554d5032303234", b"The official TRUMP2024 token rallies Trump supporters as election day nears. If Donald Trump wins, $100.000 worth of SOL will be rewarded to moonshot holders based on their contribution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmcDtgNM1PpTea6zxb6jkSFhkmjefMUpazqAYwq91E4aE6")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<TRUMP_2024>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<TRUMP_2024>(5797718667925829928, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

