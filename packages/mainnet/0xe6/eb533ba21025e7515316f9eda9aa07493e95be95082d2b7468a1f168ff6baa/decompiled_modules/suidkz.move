module 0xe6eb533ba21025e7515316f9eda9aa07493e95be95082d2b7468a1f168ff6baa::suidkz {
    struct SUIDKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDKZ>(arg0, 6, b"SUIDKZ", b"SuiDuckz", x"497427732054696d6520234475636b7a536561736f6e20235375696475636b7a45676773200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/I_Fen_K9l_400x400_75aa2996e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

