module 0x84c16f3d8bd2bdee28a70fcd572d16d3c96433d5f86f3504bfd76a3e3776aece::suidkz {
    struct SUIDKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDKZ>(arg0, 6, b"SUIDKZ", b"SuiDuckz", x"5375694475636b7a2069732061205374617274757020696e20746865204e4654206669656c64206f6e2074686520537569206e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_Fen_K9l_400x400_9968190805.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

