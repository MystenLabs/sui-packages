module 0xcc855fddf5541bf3ee5409c4585d5eabee69ed701e5fe0d6924f4ba0f00cd1be::xmas {
    struct XMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS>(arg0, 6, b"XMAS", b"Xmas Wish", b"Make our wish come true ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nr_K_Xz_TCKT_9a7_HK_Cn_JLCASN_Zg_Dod_Tg728h_Ew_Aaicx_E2_Zj_a85f95198d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

