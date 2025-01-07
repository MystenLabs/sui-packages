module 0x783a554363da82de8410e7f132d3e84b73330a2b801845b0ffddf52dbbab31db::pogslide {
    struct POGSLIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGSLIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGSLIDE>(arg0, 6, b"POGSLIDE", b"PogSlide", b"I like SLIDE, that's why I'm here to take him to the millions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R91p3_Gq6o_N2yb6_V_Afid_Ep_R_Nkm_L_Wyng4qq_T_Wweu_Y_Vnanh_1f71ff65fa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGSLIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGSLIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

