module 0x4c38555a991be7546cd234b80d7a55200abe7372574e685625fb7e2ededeb049::carts {
    struct CARTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTS>(arg0, 6, b"CARTS", b"CARROTS", b"only carrots", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXBkNQMW6Wm3KQNAifBeY4FR984oxx4sNjnYTvpHDgeuk")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<CARTS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<CARTS>(1586296115786359784, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

