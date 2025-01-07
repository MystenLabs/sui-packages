module 0x80623af3901b35833bf286a191f163d9f957933e1994c5b9e264ba6969a0ee60::chifox {
    struct CHIFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIFOX>(arg0, 6, b"CHIFOX", b"SUI CHINESE FOX", b"A new meme coin $ChineseFox || This fox will go to space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XZ_Yn_Nf_Wkk_HG_7j_W9e3hm_Tz_Gwmw_A1ui_Ykj7_V_Fzx4_Nf_BQ_Ww_3d0129f072.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

