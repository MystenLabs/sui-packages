module 0x3c2274a9497dbcbd92611303bd1bbc217e797467ffb19484499cde29311413e9::steamsloth {
    struct STEAMSLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMSLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMSLOTH>(arg0, 6, b"STEAMSLOTH", b"Steam Sloth", x"5374756d626c6564206d79207761792066726f6d20537465616d20746f2074686520426c6f636b636861696e2e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Rf_FQFQAM_Bpf2_Au_Yy_E_Rp_Gk_Heavp5v_Jj7d_Tt2q_Yqfbypc_1f29c27ccd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMSLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMSLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

