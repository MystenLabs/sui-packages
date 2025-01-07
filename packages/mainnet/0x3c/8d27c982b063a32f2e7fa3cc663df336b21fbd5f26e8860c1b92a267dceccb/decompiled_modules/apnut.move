module 0x3c8d27c982b063a32f2e7fa3cc663df336b21fbd5f26e8860c1b92a267dceccb::apnut {
    struct APNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APNUT>(arg0, 6, b"apnut", b"armoured pnut", b"armoured pnut would have never lost to those commies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQF38oVRC6JLp1dZAKXi5EtiESe4jNy2L1G7Wm6mh8iRY")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<APNUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<APNUT>(6550950788047698213, v0, v1, 0x1::string::utf8(b"https://x.com/armoured_pnut"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

