module 0x76d23d1b2d8f4f6dc3b32accae541810ab508d891ad2a30a2cd7ac157fd97bb7::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"SUPER SUIYAN", b"It's the Super Suiyan cycle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbnM9L7FdGNLYgNpA6kmJw3sSf4QFRm36QEaqwmzk5Zn8")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIYAN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIYAN>(6781236269646845159, v0, v1, 0x1::string::utf8(b"https://x.com/supersuiyan"), 0x1::string::utf8(b"https://suiyancoin.com/"), 0x1::string::utf8(b"https://t.me/SUPERSUIYAN"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

