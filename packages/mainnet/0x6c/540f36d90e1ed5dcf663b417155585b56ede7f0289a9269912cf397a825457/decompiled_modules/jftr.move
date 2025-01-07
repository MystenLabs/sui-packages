module 0x6c540f36d90e1ed5dcf663b417155585b56ede7f0289a9269912cf397a825457::jftr {
    struct JFTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFTR>(arg0, 6, b"JFTR", b"Justice For The Rugged", x"4265636175736520776527766520616c6c206265656e207275676765642e20497427732074696d6520666f72206a7573746963652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tf_Cb_D8_St8_B_Ars_Sb_NNE_9_YMG_1k_E_Za_Ks1_RN_6_Hb_V_Mh_Qx_PWYS_9f43d45955.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

