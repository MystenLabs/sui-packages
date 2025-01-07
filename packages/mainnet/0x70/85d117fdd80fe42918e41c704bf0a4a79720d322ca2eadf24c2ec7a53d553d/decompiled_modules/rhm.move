module 0x7085d117fdd80fe42918e41c704bf0a4a79720d322ca2eadf24c2ec7a53d553d::rhm {
    struct RHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RHM>(arg0, 6, b"RHM", b"RHESUS MONKEY by SuiAI", b"AI Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000041761_93f947b9ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RHM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

