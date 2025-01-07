module 0x9cd1754646c095963087261ed9a27b04292426f7f98a3e4923d5a1bfe29874f8::rkamala {
    struct RKAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKAMALA>(arg0, 6, b"rKamala", b"Retardio Kamala", b"Kamala has gone full retardio!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPefXawJjkrfWEk2Pt8hQUHFmCEZCbCBYbaf3p7naQnea")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<RKAMALA>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<RKAMALA>(6740299430364802117, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/rkamalasui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

