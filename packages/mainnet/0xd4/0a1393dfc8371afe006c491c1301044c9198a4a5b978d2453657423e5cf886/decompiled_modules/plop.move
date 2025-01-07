module 0xd40a1393dfc8371afe006c491c1301044c9198a4a5b978d2453657423e5cf886::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 6, b"Plop", b"PlopSui", x"4f6666696369616c206d6173636f74206f66202453554920636861696e20f09f92a720706c6f7020706c6f7020f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTE4PwdbR5ffPETh6uTbrMBRp9TWvNtBjguG9Ky8NsqaM")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<PLOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<PLOP>(9087309891094728799, v0, v1, 0x1::string::utf8(b"https://x.com/plopsui"), 0x1::string::utf8(b"https://www.plopsui.com/"), 0x1::string::utf8(b"https://t.me/plopsuiportal"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

