module 0x4975e31d8bad38e7f2bc2c4fe60e867e8d03e8161d4d29e78cbfd853555ec1c1::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"pizza", b"pizzasui", b"Fun for $Pizza Sui Hop Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXCcVQRykHR9LJQi3a1jSLD7mT4aqDw2u418WqkRM7FFj")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PIZZA>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PIZZA>(11866800608904328428, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

