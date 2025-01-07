module 0x69646d64f7c10a8a2154b617f4fe19f00f2e698b86ca393ef3dfc960a3fe33f7::inbred {
    struct INBRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: INBRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INBRED>(arg0, 6, b"INBRED", b"INBRED CAT SUI", x"506f70756c6172206d656d6520696e6272656420636174206c657473206765742074686973206272656164206f6e636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_46_f438ba646f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INBRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INBRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

