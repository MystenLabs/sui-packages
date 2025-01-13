module 0xb06444de159f79a143f400e3222c18684aae1c6f2cdba8974aede385d910788b::frnz {
    struct FRNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FRNZ>(arg0, 6, b"FRNZ", b"Friend by SuiAI", b"Friendly ai who will care about you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image004_98e055be2e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRNZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRNZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

