module 0x61987c04d8db9a8005f6605de52179e324fc133e2733f44984f200fc9eb88e03::hopfun {
    struct HOPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFUN>(arg0, 6, b"Hopfun", b"Hopfun", b"HOPFUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmRsoyPX9rPxfS6WjVxBxygpJTywFMYhpt3uZ9b5wUKciZ")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPFUN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPFUN>(17301143919278179685, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

