module 0xfc4ce3b927206c95e9596e56f79a8754cdb5099ef673fb468881d34973b655b4::hotter {
    struct HOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTTER>(arg0, 6, b"Hotter", b"Hotter", b"Hottest Otter on Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmdijSRgKiEJ3Ps1kifv28c4thzBKqdywHnz2CGTYceYT4")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOTTER>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOTTER>(11710204554944478059, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

