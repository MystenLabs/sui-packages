module 0xd4072890c6708b851d3a0ae370eb2cf774ee514552767e8fb11339d0d789427::suidckz {
    struct SUIDCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDCKZ>(arg0, 6, b"SUIDCKZ", b"SuiDuckz", x"496e74726f647563696e672c205375694475636b7a2069732061205374617274757020696e20746865204e4654206669656c64206f6e2074686520537569206e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_Fen_K9l_400x400_dfea536bb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDCKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDCKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

