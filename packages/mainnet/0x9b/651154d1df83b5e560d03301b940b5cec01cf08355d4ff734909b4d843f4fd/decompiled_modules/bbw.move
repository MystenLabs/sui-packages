module 0x9b651154d1df83b5e560d03301b940b5cec01cf08355d4ff734909b4d843f4fd::bbw {
    struct BBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBW>(arg0, 6, b"BBW", b"Blue Banana Wall Tape", b"Its a fucking blue banana taped to a wall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_C_Dh_Vb_Gbd_L_Xh_Mhnsr_Fn_Adj6_LBX_Dk6_Czn_S_Ahx_Yc4_YW_Yjz_00ac53898a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

