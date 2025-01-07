module 0x92ab483826a15ef6358bfe1b9bf3e963707bc81ac35b9a1479b1210dcea3ab3::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PAPA>(arg0, 5512531951620062845, b"papa", b"papa", b"Papa sui", b"https://images.hop.ag/ipfs/QmQLg1baonXESU5sGwQX7BV3BsertZn9JfASGNKhSTwRQJ", 0x1::string::utf8(b"https://x.com/papaonsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/papasui"), arg1);
    }

    // decompiled from Move bytecode v6
}

