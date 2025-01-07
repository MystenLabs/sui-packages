module 0xff6d855f2876cd5b5bfaa7fcbbb9721f447290606699a6207b4a7757e3eea0ae::sgf {
    struct SGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGF>(arg0, 6, b"SGF", b"Smoking Sui Giga Fish", b"No soy larps. No jeets. Only $SGF. What are you waiting for? Join us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdF5cs4EQtKrFzaWw6HJjmn3Xg35N5xxK6vDS25F39e1j")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SGF>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SGF>(14758365550140298439, v0, v1, 0x1::string::utf8(b"https://x.com/SGF_sui"), 0x1::string::utf8(b"https://www.smokingsuigigafish.xyz/"), 0x1::string::utf8(b"https://t.me/sgfportal"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

