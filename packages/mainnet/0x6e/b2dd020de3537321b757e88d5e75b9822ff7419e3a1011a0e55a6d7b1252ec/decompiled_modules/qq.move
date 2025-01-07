module 0x6eb2dd020de3537321b757e88d5e75b9822ff7419e3a1011a0e55a6d7b1252ec::qq {
    struct QQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQ>(arg0, 6, b"QQ", b"Open ICQ", b"QQ is QQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmea_Z_Lapwb_EBF_Qo4_Hqtojvfduku_Jj_HTKY_9_U_Mz_Ye3_Tjo_Y_Gi_b96c470dcb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

