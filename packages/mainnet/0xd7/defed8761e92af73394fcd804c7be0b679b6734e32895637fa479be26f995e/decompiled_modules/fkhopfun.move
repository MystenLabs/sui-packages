module 0xd7defed8761e92af73394fcd804c7be0b679b6734e32895637fa479be26f995e::fkhopfun {
    struct FKHOPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKHOPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKHOPFUN>(arg0, 6, b"FKHOPFUN", b"FUCK HOPFUN", b"FUCK THIS DELAYED BAD LAUNCH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmeJTNVE4rNjHtkpua8ELKt4PjD7Rhijf468bZcy8gqw9v")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FKHOPFUN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FKHOPFUN>(17931875899663734924, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

