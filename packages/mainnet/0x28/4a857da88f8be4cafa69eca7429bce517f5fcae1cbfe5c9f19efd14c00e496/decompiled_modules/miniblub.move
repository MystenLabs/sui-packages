module 0x284a857da88f8be4cafa69eca7429bce517f5fcae1cbfe5c9f19efd14c00e496::miniblub {
    struct MINIBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MINIBLUB>(arg0, 2660015609345095824, b"miniBLUB", b"miniBLUB", b"The smallest fish in the water. Not the big Blub. Fan Token. Earnings go to BLUB Treasure. No rug, promise!", b"https://images.hop.ag/ipfs/QmRFJoxrmEuFy16WbLXQok3GqyLT9VmPuFk9SNVKGsVG9c", 0x1::string::utf8(b"https://x.com/blubsui"), 0x1::string::utf8(b"https://www.blubsui.com"), 0x1::string::utf8(b"https://t.me/blubsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

