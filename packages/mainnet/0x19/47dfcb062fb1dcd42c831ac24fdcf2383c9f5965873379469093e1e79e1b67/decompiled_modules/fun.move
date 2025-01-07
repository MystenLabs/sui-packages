module 0x1947dfcb062fb1dcd42c831ac24fdcf2383c9f5965873379469093e1e79e1b67::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 6, b"FUN", b"FUN Token", b"01st HOP fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQvXjD3avEQMvYHXK9qGPA4ixefgNqQXLfyd5PiLz3y35")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FUN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FUN>(13582353284702057747, v0, v1, 0x1::string::utf8(b"https://x.com/HopAggregator"), 0x1::string::utf8(b"https://hop.ag/fun"), 0x1::string::utf8(b"https://t.me/+biKJEa8POMViNTM5"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

