module 0x422e45ada00fc49369187e68f238c6b490207a838deb2038cd341edb0184b231::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT>(arg0, 6, b"Peanut ", b"Peanut", x"4974e2809973206f7572206a6f6220746f2068656c702073617665207065616e75742074686520737175697272656c21205369676e20746865207065746974696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPncTECroMSa7Jxth4R69QNWwssKFFLrQ5Nvh3rFqBiJP")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PEANUT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PEANUT>(6098379277344223979, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

