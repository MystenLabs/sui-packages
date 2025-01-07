module 0x461b05d4d59a00868259e8ddd10a05596da870b5001d7c365be09b2a30b6d629::wabwifhat {
    struct WABWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WABWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WABWIFHAT>(arg0, 6, b"WABWIFHAT", b"Wab Wif Topha", b"The wab has a tophat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Uv_MHW_Dh7_Cfoc_M_Tfk5_Suh_E_Lc_NT_Xo_Usho_Y8_C_Rc_Byu_A1w_T_deac217d71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WABWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WABWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

