module 0x3dab36be3fc3ec464ec095ea9adcb1c81587ad750d7d8ceca626f0fda37992fa::worm_jim {
    struct WORM_JIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORM_JIM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WORM_JIM>(arg0, 1490301944399161946, b"Worm", b"Worm Jim", b"Memcoin was created for the sake of memory and passion for the game on Sega, Worm Jim. Dedicated to everyone who played or remembers this cult game.", b"https://images.hop.ag/ipfs/QmPyfEeXs7vgoVgJi7UR363fRCnKZVkznm7KoubhteFNJj", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

