module 0x3551a49d4fc6766b707ca465512472267e905a203f450bd1bc96a79dd6f5405e::unicat {
    struct UNICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICAT>(arg0, 6, b"UNICAT", b"UNICAT SUI", b"UNICAT ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_2024_11_05_T232341_235_149988180b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

