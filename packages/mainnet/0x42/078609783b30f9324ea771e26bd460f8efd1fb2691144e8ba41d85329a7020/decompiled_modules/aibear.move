module 0x42078609783b30f9324ea771e26bd460f8efd1fb2691144e8ba41d85329a7020::aibear {
    struct AIBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBEAR>(arg0, 6, b"AIBEAR", b"AI Bear", b"\"Bears love AI too.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWDKkhGNZqAopFdXJWvjFrhvdy8sqYg7WspWCd3jrekoK")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<AIBEAR>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<AIBEAR>(4186762115692606350, v0, v1, 0x1::string::utf8(b"https://x.com/AI_Bear24"), 0x1::string::utf8(b"https://aibear.fun/"), 0x1::string::utf8(b"https://t.me/aibear24"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

