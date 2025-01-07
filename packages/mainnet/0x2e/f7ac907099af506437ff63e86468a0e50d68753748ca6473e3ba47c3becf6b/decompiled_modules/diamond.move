module 0x2ef7ac907099af506437ff63e86468a0e50d68753748ca6473e3ba47c3becf6b::diamond {
    struct DIAMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMOND>(arg0, 6, b"DIAMOND", b"Diamond Hands Guy", b"Deep in the Sui trenches but its okay bc im just a diamond hands guy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tow_R6_P_Gvw3u_Pih_Ck_R_Cfo_QXXB_4wz8xc_Caqo_B_Aenypump_0d6cf44ae0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAMOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

