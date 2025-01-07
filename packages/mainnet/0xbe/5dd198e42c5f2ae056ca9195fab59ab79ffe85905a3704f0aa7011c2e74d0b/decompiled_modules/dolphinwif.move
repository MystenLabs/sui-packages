module 0xbe5dd198e42c5f2ae056ca9195fab59ab79ffe85905a3704f0aa7011c2e74d0b::dolphinwif {
    struct DOLPHINWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHINWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHINWIF>(arg0, 6, b"DOLPHINWIF", b"Smiling Dolphin Wif Hat", b"literally just Smiling Dolphin wif a hat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOLGG_8570847964.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHINWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHINWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

