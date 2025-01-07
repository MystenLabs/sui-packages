module 0x78e1cc63cd28dc6c886976dc4263bd85add1c164b361470fe329d34df93844d8::suiyans {
    struct SUIYANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYANS>(arg0, 6, b"SUIYANS", b"Super Suiyan", b"It's the Super Suiyan cycle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQHXY6CFB9iCvec79J5YqUMozWzcMFuEfqYK658MuBJ2S")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIYANS>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIYANS>(5588993197683729162, v0, v1, 0x1::string::utf8(b"https://x.com/supersuiyan"), 0x1::string::utf8(b"https://suiyancoin.com/"), 0x1::string::utf8(b"http://t.me/SUPERSUIYAN"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

