module 0x697fc97c0de6b64510e61b11ec60a9c4205f751ed94fc6d6838c9947e6dc328e::wtef {
    struct WTEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTEF>(arg0, 6, b"Wtef ", b"Wojack depressed", x"5768792063616ee2809974204920646f20616e797468696e67206f6e207468697320736974652e0a0a486f702e736164", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmeSo8MBND3SfGGKpqYwCR7dktkQj92Fu3ezC2W5bToSLz")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<WTEF>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<WTEF>(431641588349684348, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

