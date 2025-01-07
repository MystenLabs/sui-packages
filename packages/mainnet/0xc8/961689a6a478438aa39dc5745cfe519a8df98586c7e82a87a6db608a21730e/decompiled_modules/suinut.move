module 0xc8961689a6a478438aa39dc5745cfe519a8df98586c7e82a87a6db608a21730e::suinut {
    struct SUINUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINUT>(arg0, 6, b"SUINUT", b"suinut", b"SUI was here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYThJBWxVHUC4tLg9UkLKMQPvebeb6j8wQEEcxUJraXqo")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUINUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUINUT>(16047976339754447558, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

