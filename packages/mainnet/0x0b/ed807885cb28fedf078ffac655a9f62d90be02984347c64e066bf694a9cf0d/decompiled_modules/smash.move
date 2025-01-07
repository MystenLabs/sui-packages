module 0xbed807885cb28fedf078ffac655a9f62d90be02984347c64e066bf694a9cf0d::smash {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SMASH>(arg0, 10538674484975011794, b"Sui Smash Bros", b"SMASH", b"Smashing Into Sui", b"https://images.hop.ag/ipfs/Qmd1HvXkzhRvHNMvjxpbbBjXSkBZNypfPekyfysS9KuPFh", 0x1::string::utf8(b"https://x.com/suismashbros?s=21&t=SrEJihQwEOziuZrQtunrJg"), 0x1::string::utf8(b"https://suismashbros.com/"), 0x1::string::utf8(b"https://t.me/SuiSMASHBrosPortal"), arg1);
    }

    // decompiled from Move bytecode v6
}

