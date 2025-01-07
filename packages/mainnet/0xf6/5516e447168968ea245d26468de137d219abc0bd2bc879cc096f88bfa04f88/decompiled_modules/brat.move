module 0xf65516e447168968ea245d26468de137d219abc0bd2bc879cc096f88bfa04f88::brat {
    struct BRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAT>(arg0, 6, b"BRAT", b"Bullrat", b"Among all the rats, there is a bullish one. $BRAT https://x.com/Ratating https://t.me/BRATsewers https://bullrat.org/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_NBPV_Pk8u_KMD_4_Zga_Htdxqjf_Z4_Z_Gxtfuxg_J8mi63_He1_Hs_b9585ce2ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

