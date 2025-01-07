module 0xa31adbab149e8641620ac948f548d1ee13b90622e241f914dcdf2773876d0810::nasdaq_4200 {
    struct NASDAQ_4200 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDAQ_4200, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASDAQ_4200>(arg0, 6, b"NASDAQ4200", b"Stonks", b"Stonks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmVcjLaB2WgcqdtRFrni7ZNfi2RqM222WaG7T4ZH2FFZcD")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<NASDAQ_4200>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<NASDAQ_4200>(16347033815784721236, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

