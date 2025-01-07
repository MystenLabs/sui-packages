module 0xf66a43b043e110f1eb2b5dd81e5ac0ec735c6fe1dc38f19cc4da777bc1d543f::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"Duck", b"SuiDuckz", b"New Highest Bid !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_Fen_K9l_400x400_a13a4c11f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

