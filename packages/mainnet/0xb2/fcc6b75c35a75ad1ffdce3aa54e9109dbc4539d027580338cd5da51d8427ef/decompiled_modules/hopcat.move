module 0xb2fcc6b75c35a75ad1ffdce3aa54e9109dbc4539d027580338cd5da51d8427ef::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"HopCat", b"first ever deployed cat on hopfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmaGmGXfXxwfUnn9B3HjJPdzdXPft8LhmQX18PQkk4grRb")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPCAT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPCAT>(17977788544158159352, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://hopcat.online/"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

