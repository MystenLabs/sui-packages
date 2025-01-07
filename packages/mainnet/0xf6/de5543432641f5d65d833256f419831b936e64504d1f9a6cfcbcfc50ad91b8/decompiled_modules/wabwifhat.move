module 0xf6de5543432641f5d65d833256f419831b936e64504d1f9a6cfcbcfc50ad91b8::wabwifhat {
    struct WABWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WABWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WABWIFHAT>(arg0, 6, b"WABWIFHAT", b"Wab Wif Tophat", x"5468652077616220686173206120746f706861740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Uv_MHW_Dh7_Cfoc_M_Tfk5_Suh_E_Lc_NT_Xo_Usho_Y8_C_Rc_Byu_A1w_T_d6da080f90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WABWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WABWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

