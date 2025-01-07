module 0xbbb77babea7b2d5d241a50de92370c1d4d7a55025ab8a7ae6b12bc3f47c5d23e::loafc {
    struct LOAFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOAFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOAFC>(arg0, 6, b"LOAFC", b"LOAF CAT ON SUI", b"IM LOAF CAT ON SUI. CHECK ME ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_04abe68979.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOAFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOAFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

