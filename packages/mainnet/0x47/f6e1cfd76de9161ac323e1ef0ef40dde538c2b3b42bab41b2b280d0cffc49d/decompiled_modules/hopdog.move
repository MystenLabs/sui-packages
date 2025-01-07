module 0x47f6e1cfd76de9161ac323e1ef0ef40dde538c2b3b42bab41b2b280d0cffc49d::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOG>(arg0, 6, b"HOPDOG", b"HOPDOG", b"HOP First Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmcQeLSr4LME24GRTpS5kpt5hpwPi6vEHVYeZegkFdU232")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPDOG>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPDOG>(10981581805296112358, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

