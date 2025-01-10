module 0x28246709d05d6398efc2a479c9d2cf6153980f9aff3064ceb7f59d10e4cd8766::suidex {
    struct SUIDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIDEX>(arg0, 6, b"SUIDEX", b"SuiDEX Agent by SuiAI", b"Your all-in-one AI-powered companion for smart trading on Sui Ecosystem..SuiDEX help crypto traders to tracking wallet transactions, or hunting for the next big token trend, SuiDEX Agent is here to make your life easier. Built for the Sui blockchain, this AI-powered tool is like having a personal assistant for everything crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6733_b2e41a1a4f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

