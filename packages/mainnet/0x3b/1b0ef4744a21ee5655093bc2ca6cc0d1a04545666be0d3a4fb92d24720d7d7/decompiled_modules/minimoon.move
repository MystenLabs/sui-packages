module 0x3b1b0ef4744a21ee5655093bc2ca6cc0d1a04545666be0d3a4fb92d24720d7d7::minimoon {
    struct MINIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIMOON>(arg0, 6, b"Minimoon", b"2024PT", b"EARTH IS GETTING A SECOND MOON Earth's about to pick up a new natural satellite. This \"mini-moon\" will be with us for the next two months, but it's not its first visit and it won't be the las", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T9mw2usf_QA_Kis1_Eit_QK_1s_Cfx_QX_Hju_Z_Qfiqz_Z_Ttq_E9_WEF_0bd215ec3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

