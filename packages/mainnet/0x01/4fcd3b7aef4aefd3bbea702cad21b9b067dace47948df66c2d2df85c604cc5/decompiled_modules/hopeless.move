module 0x14fcd3b7aef4aefd3bbea702cad21b9b067dace47948df66c2d2df85c604cc5::hopeless {
    struct HOPELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPELESS>(arg0, 6, b"Hopeless", b"Hopeless", b"Imagine creating a site with a team that is said to be professional, but losing to Rug Solana developers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qma9tD4Htzyd7iNoohVNcqwSpuLCn67SVwDHJGEANxwhop")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPELESS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPELESS>(18325671510764967336, v0, v1, 0x1::string::utf8(b"https://x.com/HopAggregator?t=gRrnocR4SWf5EIbyPqu2aw&s=09"), 0x1::string::utf8(b"https://hop.ag/"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

