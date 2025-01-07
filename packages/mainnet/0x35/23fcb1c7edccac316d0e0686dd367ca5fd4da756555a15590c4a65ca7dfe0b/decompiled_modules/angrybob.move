module 0x3523fcb1c7edccac316d0e0686dd367ca5fd4da756555a15590c4a65ca7dfe0b::angrybob {
    struct ANGRYBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYBOB>(arg0, 6, b"AngryBoB", b"BOB", x"4d616e79207468696e67732070697373206f666620426f622c204865e280997320616e20616e67727920646f6720f09f98a4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQQSmJMymLqNgnXRXqUmbaGaxWguh9AxnCahSZ8WADNVd")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<ANGRYBOB>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<ANGRYBOB>(7182656706626133638, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

