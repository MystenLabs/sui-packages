module 0xf0da15d4e40ab911049306db09380b0122c25c388175924df86d58394e35656f::b80085 {
    struct B80085 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B80085, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B80085>(arg0, 6, b"B80085", b"BOOBS", b"80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085 80085", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QJL_Sh_P_Kfy_C_Yt_Bp_VH_Rqa_W9r2_Qasn_Zaf_Lj_Lwfqm_DSF_Atx_U_f1b6ce281b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B80085>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B80085>>(v1);
    }

    // decompiled from Move bytecode v6
}

