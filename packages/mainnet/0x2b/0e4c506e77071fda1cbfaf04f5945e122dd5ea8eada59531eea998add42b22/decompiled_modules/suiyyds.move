module 0x2b0e4c506e77071fda1cbfaf04f5945e122dd5ea8eada59531eea998add42b22::suiyyds {
    struct SUIYYDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYYDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIYYDS>(arg0, 16664726414775436297, b"suiyyds", b"suiyyds", b"suiyyds", b"https://images.hop.ag/ipfs/QmTBA3U6XcGhH6fXyXBRXuCPMexy6hwWqSSyjGk4B1q6A8", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

