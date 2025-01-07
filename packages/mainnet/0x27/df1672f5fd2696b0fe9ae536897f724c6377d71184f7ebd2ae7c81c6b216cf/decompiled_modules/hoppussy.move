module 0x27df1672f5fd2696b0fe9ae536897f724c6377d71184f7ebd2ae7c81c6b216cf::hoppussy {
    struct HOPPUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPUSSY>(arg0, 6, b"HOPPUSSY", b"hoppussy", b"First meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmPoRLCfJUDefzMeB8CRnfxMqDfH96BuEmmSpMXQqq8DKA")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPPUSSY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPPUSSY>(15036659767300121841, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

