module 0xd5d5acaabfa8d6329d3424d06fe87fadd221727c53d15db5967f2e266cf6c41d::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"Melania", x"6d616b6520616d657269636120677265617420616761696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MELANIA_T_Aywpj_I_Gl_TA_Jws_JI_Ey_7d18fff9bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

