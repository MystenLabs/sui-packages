module 0x9058bc23103ea6acbaab9a76b023a07361896d78610dade9068bc8a0c7089ef8::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"SHARK", b"$SHARK surges from the $SUI ocean and unleashing a fresh wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmek5ZyUAektrzmq5VynwRFirMBQUgU1StKhuDLacGgk1b")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SHARK>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SHARK>(6405361649827837686, v0, v1, 0x1::string::utf8(b"https://x.com/SharkOnSui"), 0x1::string::utf8(b"https://sharkonsui.fun/"), 0x1::string::utf8(b"https://t.me/sharkonsui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

