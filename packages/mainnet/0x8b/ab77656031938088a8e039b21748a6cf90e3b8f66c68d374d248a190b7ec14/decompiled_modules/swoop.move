module 0x8bab77656031938088a8e039b21748a6cf90e3b8f66c68d374d248a190b7ec14::swoop {
    struct SWOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOP>(arg0, 6, b"SWOOP", b"Swoop", b"Swoop da poop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYGcjMQEVqv5DnLNKKH4gYuLi457vheuadKYpgbFhCN4a")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SWOOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SWOOP>(15396997576798349398, v0, v1, 0x1::string::utf8(b"https://x.com/SwoopOnSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/swooponsui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

