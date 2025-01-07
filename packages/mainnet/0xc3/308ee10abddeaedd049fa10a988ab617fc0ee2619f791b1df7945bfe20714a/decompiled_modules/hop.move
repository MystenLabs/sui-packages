module 0xc3308ee10abddeaedd049fa10a988ab617fc0ee2619f791b1df7945bfe20714a::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"HopFun", b"For the best price with zero fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQvXjD3avEQMvYHXK9qGPA4ixefgNqQXLfyd5PiLz3y35")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOP>(17388473579925546454, v0, v1, 0x1::string::utf8(b"https://x.com/HopAggregator"), 0x1::string::utf8(b"https://suirex.xyz/"), 0x1::string::utf8(b"https://t.me/+biKJEa8POMViNTM5"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

