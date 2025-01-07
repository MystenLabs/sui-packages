module 0x83ce7fd0a8819c815f06823e4435c572fcf31d36dbd5f5b9325954696df4bab6::nossy {
    struct NOSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOSSY>(arg0, 6, b"NOSSY", b"catwifnosejob", b"The cat has a fokin nose job and he is very cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdQ8fAoh7yTWaydLewGcRd3b9ykCz7t6UdfhqHhVLtLPP")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<NOSSY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<NOSSY>(9734951903471138211, v0, v1, 0x1::string::utf8(b"https://x.com/catwifnosejob"), 0x1::string::utf8(b"https://www.catwifnosejob.xyz/"), 0x1::string::utf8(b"https://t.me/catwifnosejob"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

