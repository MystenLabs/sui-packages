module 0x89307266f48bdc9ae6eb68c1b4e150460f5e9cf8d4ad9f3a2d28ec51f7b8d50e::fuckoff {
    struct FUCKOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKOFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FUCKOFF>(arg0, 15314250927282186483, b"FUCKOFF", b"Fuckoff", b"NO LGBTQ", b"https://images.hop.ag/ipfs/QmRBRePrVwJaiHAHPXhMRwGaLrZQW657zrzQdNqqff13rJ", 0x1::string::utf8(b"https://x.com/ChikoPhoenix_/status/1854385973016076331"), 0x1::string::utf8(b"https://www.hrw.org/topic/lgbt-rights"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

