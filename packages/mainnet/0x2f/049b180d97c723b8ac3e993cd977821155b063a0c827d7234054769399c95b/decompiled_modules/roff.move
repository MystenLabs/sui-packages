module 0x2f049b180d97c723b8ac3e993cd977821155b063a0c827d7234054769399c95b::roff {
    struct ROFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROFF>(arg0, 6, b"ROFF", b"ROFF SUI", x"5255464620564942452053454354494f4e205355492c2074686973206661636520697320776f7274682074656e2062696c6c696f6e20746f6b656e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g4_F39q_Y_400x400_cc72f41f3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

