module 0x4c31cf94bef22b75517b2ad72ef384b7f0cf64497607ce4e7309191aa8f79f1c::mother {
    struct MOTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTHER>(arg0, 6, b"MOTHER", b"MOTHER IGGY", x"4e6f20796f7520617265e280a6202a244d4f5448455220697320746865206f6e6c79207469636b65722049e280996d206173736f63696174656420776974682e20746865726520617265206e6f2064657269766174697665732e20626577617265206f66207363616d732a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPeS4kL3Fns3714U5uZt4jQc8yeGXY1JGRHHDLATn2Ydn")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MOTHER>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MOTHER>(9684040171685750713, v0, v1, 0x1::string::utf8(b"https://x.com/IGGYAZALEA"), 0x1::string::utf8(b"https://www.mother.fun/"), 0x1::string::utf8(b"https://t.me/motheriggy"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

