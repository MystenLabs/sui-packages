module 0xc33b5e8f823c376cd6c7f4c4c41038f459131e9a0794c5bc7b9ecf2de10b1354::ssp {
    struct SSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSP>(arg0, 6, b"SSP", b"Super Saiyan Pepe", x"5475726e20796f75722063727970746f2077616c6c657420696e746f20612053757065722053616979616e2057616c6c65740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZW_Xu8goq9z_ZBPGR_8_E_Pbd_QH_Lb_Nqenh_Ei_T_Rb_Hs_KA_Eq_VENH_ff1c60dd6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

