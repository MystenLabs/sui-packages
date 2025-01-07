module 0xfc34bb1abad3da4433e7450d7723e61e28905b801dede8abf8c28d120ff5e61::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GHOST", b"GHOSTBUSTERS", b"Whatcha gonna buy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdYVstP8gYJ9qcT6LvuNtaXUXd1oemkKPfvxi8XNBNQm9")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<GHOST>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<GHOST>(15022599730522656794, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

