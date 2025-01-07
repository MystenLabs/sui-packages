module 0x50e45bed3e612f40974711d6fe65ba164fdcbb213c655b9a09e81ffea7879977::edging {
    struct EDGING has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDGING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDGING>(arg0, 6, b"EDGING", b"EDGING ON SUI", b"I LOVE EDGING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/edge_f4ea501791.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDGING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDGING>>(v1);
    }

    // decompiled from Move bytecode v6
}

