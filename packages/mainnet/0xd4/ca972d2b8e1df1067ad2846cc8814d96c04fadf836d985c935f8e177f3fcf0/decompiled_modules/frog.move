module 0xd4ca972d2b8e1df1067ad2846cc8814d96c04fadf836d985c935f8e177f3fcf0::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"Frogger the FROG", b"Coolest FROG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmeqJeebVwbaen94yQy5cKp66w5a2XD8bRYHt99psyqf3E")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FROG>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FROG>(6435937536935886104, v0, v1, 0x1::string::utf8(b"https://x.com/frogger_sui"), 0x1::string::utf8(b"https://frogonsui.com/"), 0x1::string::utf8(b"https://t.me/froggerthefrogonsui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

