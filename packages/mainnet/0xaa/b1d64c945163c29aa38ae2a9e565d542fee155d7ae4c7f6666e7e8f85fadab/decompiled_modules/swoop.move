module 0xaab1d64c945163c29aa38ae2a9e565d542fee155d7ae4c7f6666e7e8f85fadab::swoop {
    struct SWOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOP>(arg0, 6, b"SWOOP", b"Swoop", x"f09f90a4f09f92a720576f6f7020576f6f7020576f6f7020f09f92a7f09f90a4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYGcjMQEVqv5DnLNKKH4gYuLi457vheuadKYpgbFhCN4a")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SWOOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SWOOP>(15300906153752390182, v0, v1, 0x1::string::utf8(b"https://x.com/SwoopOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/swooponsui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

