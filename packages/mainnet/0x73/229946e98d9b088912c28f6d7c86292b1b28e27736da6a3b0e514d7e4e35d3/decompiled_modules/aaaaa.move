module 0x73229946e98d9b088912c28f6d7c86292b1b28e27736da6a3b0e514d7e4e35d3::aaaaa {
    struct AAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AAAAA>(arg0, 3585504913126204474, b"AAAA CAT", b"AAAAA", b"Can't stop won't stop won't stop (thinking about Sui)", b"https://images.hop.ag/ipfs/QmQ5twR5P4TjAuxnDuhLhLEUksuLkCxbKXiFiQV1orHzwS", 0x1::string::utf8(b"https://x.com/aaaCatSui"), 0x1::string::utf8(b"https://www.aaacatsui.com/"), 0x1::string::utf8(b"https://t.me/aaaCatSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

