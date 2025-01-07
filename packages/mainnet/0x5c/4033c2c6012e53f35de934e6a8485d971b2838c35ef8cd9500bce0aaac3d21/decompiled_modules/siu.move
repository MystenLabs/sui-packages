module 0x5c4033c2c6012e53f35de934e6a8485d971b2838c35ef8cd9500bce0aaac3d21::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIU", b"SIU SIUUU SIUUUUU SIUUUU SIUUU SIU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWtAVBvGGHAyDq8Lyb2tTSBptFAdqRRsvxBNsFJMsoAPA")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SIU>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SIU>(11907273223426370114, v0, v1, 0x1::string::utf8(b"https://x.com/SIU_SUImeme"), 0x1::string::utf8(b"http://SIUmeme.xyz"), 0x1::string::utf8(b"https://t.me/SIUcomunity"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

