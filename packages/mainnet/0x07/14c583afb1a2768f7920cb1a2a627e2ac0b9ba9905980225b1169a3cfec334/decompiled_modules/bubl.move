module 0x714c583afb1a2768f7920cb1a2a627e2ac0b9ba9905980225b1169a3cfec334::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BUBL>(arg0, 16029773323543789357, b"BUBL on SUI", b"BUBL", b"Get ready to experience the magic of BUBL. The wave of bubbles on #Sui is just beginning. Don't miss out on this journey.", b"https://images.hop.ag/ipfs/QmPWpjTPJn5U4TPckrdM3xwrGvjN2FJNvCoj4WnQ1xKoDA", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://t.co/M532IXhjQV"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

