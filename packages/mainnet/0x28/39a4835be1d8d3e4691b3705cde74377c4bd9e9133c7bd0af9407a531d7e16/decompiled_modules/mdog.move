module 0x2839a4835be1d8d3e4691b3705cde74377c4bd9e9133c7bd0af9407a531d7e16::mdog {
    struct MDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDOG>(arg0, 6, b"Mdog", b"Murads Dog", b"Murad's dog on movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tobj_EA_5_Trxyp1g_SS_7qt_W_Nd_REC_Paw3csy_JNR_5_Zq_AW_Fh_Cr_c686546f53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

