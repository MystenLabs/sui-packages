module 0xf85b8a27423a1c82101aad27739a4db9d205f98876578995d1cdcceb45cb3012::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 6, b"YUMI", b"Yumi", b"yumi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcdyh_BCB_Ahk_KPHA_2_Ubaz_Zmi_ZV_Ftr_Ub_D_Wa_BKSM_Ncud_Dk9i_53c3fc8e72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

