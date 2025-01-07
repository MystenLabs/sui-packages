module 0xb2491f015ca3ffee890570bf7eaf67c95d545fca5f4eb5fb3e70ee6db4f3a29f::smash {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SMASH>(arg0, 3951429132764777990, b"Sui Smash Bros", b"SMASH", b"Smashing Into SUI", b"https://images.hop.ag/ipfs/Qmd1HvXkzhRvHNMvjxpbbBjXSkBZNypfPekyfysS9KuPFh", 0x1::string::utf8(b"https://x.com/suismashbros?s=21&t=SrEJihQwEOziuZrQtunrJg"), 0x1::string::utf8(b"https://suismashbros.com/"), 0x1::string::utf8(b"https://t.me/SuiSMASHBrosPortal"), arg1);
    }

    // decompiled from Move bytecode v6
}

