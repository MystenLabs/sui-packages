module 0x6a201a57e85c335ebacd8333d47e1ef824316dc1cb3193fe912a5860d9f9c727::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"BILLY", b"The community is bullish about Billy (BILLY) today.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTf9tGmZXAuDG5BbYNG2iDomHudQqDVdArTwhsXS4cVqU")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<BILLY>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<BILLY>(3649090935032269140, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

