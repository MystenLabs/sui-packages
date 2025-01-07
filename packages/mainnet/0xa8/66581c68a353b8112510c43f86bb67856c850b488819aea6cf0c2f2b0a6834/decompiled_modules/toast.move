module 0xa866581c68a353b8112510c43f86bb67856c850b488819aea6cf0c2f2b0a6834::toast {
    struct TOAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAST>(arg0, 6, b"TOAST", b"HOP TOAST CAT", b"firts toast on hop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmVLxXBdm3ijhZ3mEQZtaX8H3H6SgZdRyCfDfjurndQmHP")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<TOAST>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<TOAST>(12712485222948071003, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/suitoastcat"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

