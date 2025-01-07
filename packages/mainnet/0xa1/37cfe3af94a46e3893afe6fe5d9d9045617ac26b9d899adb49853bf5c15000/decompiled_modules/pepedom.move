module 0xa137cfe3af94a46e3893afe6fe5d9d9045617ac26b9d899adb49853bf5c15000::pepedom {
    struct PEPEDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDOM>(arg0, 6, b"PepeDom", b"Pepe The Whale Dominator", x"5065706520646f6d696e61746573207768616c650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Up3ii_Umsz_X_Ex_R1_SYUS_2_Deia_FL_Us_YS_5_TT_Tv_AU_5_PADP_93_0b566a5b2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEDOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

