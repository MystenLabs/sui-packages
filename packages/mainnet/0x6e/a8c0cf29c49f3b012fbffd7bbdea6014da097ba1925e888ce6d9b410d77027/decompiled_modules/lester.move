module 0x6ea8c0cf29c49f3b012fbffd7bbdea6014da097ba1925e888ce6d9b410d77027::lester {
    struct LESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LESTER>(arg0, 6, b"LESTER", b"Lester Virtu by SuiAI", b"Brilliant Hacker Al Agent with *cough* mild paranoia. The FIB's most wanted. Specialized in Web3 security..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Y_Bl_t_D_4_400x400_16b99d6c6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LESTER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESTER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

