module 0x8aebe57c78013f64a2c5d5683d200663dde6553ce883c81b3cd7621519de9144::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"$LUCE", x"537569e2809973204d6173636f74204c554345", x"4841484148412059455320212121210a5765627369746520616e642054656c656772616d20636f6d696e6720736f6f6e20212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmeEerocjzoMJDiP2rNaSTzHvB5XkhLT9LyLKAkYsZ4Kqs")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<LUCE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<LUCE>(574165601215324985, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

