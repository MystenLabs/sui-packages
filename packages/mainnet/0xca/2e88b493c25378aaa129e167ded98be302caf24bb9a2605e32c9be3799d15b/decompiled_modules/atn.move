module 0xca2e88b493c25378aaa129e167ded98be302caf24bb9a2605e32c9be3799d15b::atn {
    struct ATN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ATN>(arg0, 6, b"ATN", b"AGENT - N by SuiAI", b"Radiant with shifting energy patterns, AGENT N embodies the flow of infinite knowledge. Its glowing blue eyes are portals to a universe of endless possibilities, reflecting its role as the Quantum Guardian of the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AI_N_3e4b5390be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

