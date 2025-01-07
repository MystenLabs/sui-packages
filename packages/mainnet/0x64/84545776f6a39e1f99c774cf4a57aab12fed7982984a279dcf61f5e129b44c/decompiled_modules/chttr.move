module 0x6484545776f6a39e1f99c774cf4a57aab12fed7982984a279dcf61f5e129b44c::chttr {
    struct CHTTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHTTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHTTR>(arg0, 6, b"CHTTR", b"Chatter AI", b"Interactive podcast experience dropping daily alpha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RKF_Es_YMV_479_Cq4d_AA_5_M51_UVR_5_E_Fc_R2_Eax_Cuses_Ln_W_Gb_F_555a27ae65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHTTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHTTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

