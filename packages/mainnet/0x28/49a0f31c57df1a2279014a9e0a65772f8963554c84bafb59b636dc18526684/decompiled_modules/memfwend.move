module 0x2849a0f31c57df1a2279014a9e0a65772f8963554c84bafb59b636dc18526684::memfwend {
    struct MEMFWEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMFWEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMFWEND>(arg0, 6, b"MEMFWEND", b"MEFWENDS", x"494c4c20414c57415953204245204845524520464f5220594f552e204c4f59414c20414e44205452554520414e4420415320594f5552204245535420465249454e442e20494c4c204d414b4520535552452049204e45564552204c455420594f5520444f574e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ux_PWULFM_Qh_Du5j_Roz_G2_Wp_R9sna_SF_Jw_T_Vf_Bo_STBV_Lyqk_C_1b0047298b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMFWEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMFWEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

