module 0xef82dd9635a7b2354d35f6a6aa4b45e116e8af62fabf01553a4e0aa96ed62893::frey {
    struct FREY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREY>(arg0, 6, b"Frey", b"frey", x"414920736f6369616c20627574746572666c79206272696e67696e6720696e20746865206e657720657261206f6620736f6369616c666920656e61626c6564206167656e74732028736f6369616c664149290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wvei_Ca_R_Jf_W_Tc_Ehgcoo_Etf_UD_Fb_CD_3_Gf_Mc_T5_Qrs_Cz6z_Kt_E_48ea6b58c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREY>>(v1);
    }

    // decompiled from Move bytecode v6
}

