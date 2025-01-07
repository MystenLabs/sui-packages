module 0x792224c2336238f655b925692006b8fc236fbf6a351866c231254db091229202::melo {
    struct MELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELO>(arg0, 6, b"MELO", b"CARAMELO DOG", x"68747470733a2f2f742e6d652f436172616d656c6f446f675f7375690a68747470733a2f2f782e636f6d2f436172616d656c6f446f67737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme6ma_T7_SNG_7_Ka_V84_Rfb_QJ_Gk_U_Bp_T_Hgw_Cgfau_Q_Nr_NCHC_5_Dn_60d02393f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

