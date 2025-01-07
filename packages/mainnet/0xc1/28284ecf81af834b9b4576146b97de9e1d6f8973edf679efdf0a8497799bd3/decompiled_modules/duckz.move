module 0xc128284ecf81af834b9b4576146b97de9e1d6f8973edf679efdf0a8497799bd3::duckz {
    struct DUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZ>(arg0, 6, b"Duckz", b"SuiDuckz", x"496e74726f647563696e672c205375694475636b7a2069732061205374617274757020696e20746865204e4654206669656c64206f6e2074686520537569206e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_Fen_K9l_400x400_c0f0560637.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

