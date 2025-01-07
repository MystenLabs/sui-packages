module 0xd8ad5d2a41271e9cf53fb381cda6fe7692ef752797feecad41512d17277c0b6d::suittles {
    struct SUITTLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTLES, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUITTLES>(arg0, 158712768232712372, b"Suittles", b"Suittles", b"Suittles is the first  multicolored fruit-flavored lentil-shaped candies", b"https://images.hop.ag/ipfs/QmYsWHsexM6G5Wb29irPASwirRVNsa7Nio8SKNgp7rpSNd", 0x1::string::utf8(b"https://x.com/TenzinJampel91/status/1857513658655584578"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

