module 0x92bd2316e47b44b844297c6085ca4e5edf464698457af3164ebc9ad509bba8ac::kolwai {
    struct KOLWAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLWAI>(arg0, 6, b"Kolwai", b"Kolwaii", b"Kolwaii...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TZ_33_V8_U_Dnr_BS_Jf_G_Ja_PUF_13s_HDAS_6_Eytwj7_A9_Ccg_Ebk2v_e23ce1b136.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLWAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLWAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

