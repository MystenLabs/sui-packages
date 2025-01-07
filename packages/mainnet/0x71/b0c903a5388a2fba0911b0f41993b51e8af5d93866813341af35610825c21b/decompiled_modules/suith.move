module 0x71b0c903a5388a2fba0911b0f41993b51e8af5d93866813341af35610825c21b::suith {
    struct SUITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUITH>(arg0, 6, b"SUITH", b"SUIthereum", b"Sui is the ethereum killer. ..Sui's market cap will flip the ethereum market cap. ..The SUITH AI agent will reach very high market capitalisation, allowing money to flow into the Sui network. ..To support this goal, buy in large quantities, never sell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/c23baf86_6f61_4ea9_a322_2b5113236e87_b1cc650672.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

