module 0xa97195d771a8b2d3a33208799b17993d87327c37727ff1fc9493a1ecbd44ab07::smash {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SMASH>(arg0, 13028532388351719627, b"Sui Smash Bros", b"SMASH", b"Smashing Into SUI", b"https://images.hop.ag/ipfs/Qmd1HvXkzhRvHNMvjxpbbBjXSkBZNypfPekyfysS9KuPFh", 0x1::string::utf8(b"https://x.com/suismashbros?s=21&t=SrEJihQwEOziuZrQtunrJg"), 0x1::string::utf8(b"https://suismashbros.com/"), 0x1::string::utf8(b"https://t.me/SuiSMASHBrosPortal"), arg1);
    }

    // decompiled from Move bytecode v6
}

