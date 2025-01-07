module 0xd5dda7beabc85f3bcc8570bad5ef2e3e05c1ce08f47f8ad405096b6487ef994d::mmfuckup {
    struct MMFUCKUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMFUCKUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMFUCKUP>(arg0, 6, b"MMFUCKUP", b"Gotbit ZM quant CLS global", b"Let's support them! Federal prosecutors in Boston charged the firms Gotbit, ZM Quant, CLS Global and the leaders and employees of those and other companies in a takedown that has led to four arrests, agreements by five people to plead guilty and the seizure of over $25 million worth of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TS_Dd_Dby_B_Dr_SFB_Hk_Xcbx_UCK_Qugk_Xbe_TK_5_U6f_U1_ZP_Xv_F8_E_f67c069a4d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMFUCKUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMFUCKUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

