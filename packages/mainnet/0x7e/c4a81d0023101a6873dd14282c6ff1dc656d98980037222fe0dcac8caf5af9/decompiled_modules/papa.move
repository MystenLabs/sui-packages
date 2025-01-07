module 0x7ec4a81d0023101a6873dd14282c6ff1dc656d98980037222fe0dcac8caf5af9::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PAPA>(arg0, 118580957550747535, b"papa", b"papa", b"Papa sui", b"https://images.hop.ag/ipfs/QmQLg1baonXESU5sGwQX7BV3BsertZn9JfASGNKhSTwRQJ", 0x1::string::utf8(b"https://x.com/papaonsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/papasui"), arg1);
    }

    // decompiled from Move bytecode v6
}

