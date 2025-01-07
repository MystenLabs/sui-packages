module 0x26804d02c1790c26bca8d031c8a876f359ab873c06b18a54377e8b7cdc9b736a::smash {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SMASH>(arg0, 14900601800642698074, b"Sui Smash Bros", b"SMASH", b"Smashing into the Sui-Verse", b"https://images.hop.ag/ipfs/Qmd1HvXkzhRvHNMvjxpbbBjXSkBZNypfPekyfysS9KuPFh", 0x1::string::utf8(b"https://x.com/suismashbros?s=21&t=SrEJihQwEOziuZrQtunrJg"), 0x1::string::utf8(b"https://suismashbros.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

