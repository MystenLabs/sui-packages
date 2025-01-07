module 0x51f8c180d805433bdb165af77e6ce6fbbadb6f06b3a1ec17859ca6395bf1ce2c::gfbf {
    struct GFBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFBF>(arg0, 6, b"GFBF", b"My Girlfriend's Boyfriend", b"How do I please my girlfriend? Find her a boyfriend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWGnNh9RorEvoJZTPJN56qwzYo1ywAoKaVgjbfoAFR5jf")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<GFBF>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<GFBF>(16495469484179253371, v0, v1, 0x1::string::utf8(b"https://x.com/GFBFonSUI"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

