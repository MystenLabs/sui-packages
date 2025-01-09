module 0x7a5e93947120e53c11610da890df202be9f5c1364bb3388311bcca6f6a2a1755::trendy {
    struct TRENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENDY>(arg0, 6, b"TRENDY", b"Trendy AI", x"5472656e647920414920285452454e4459290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbw_RC_Qp_XE_Mw_Xh_P_Li_Em_DE_Dk_BU_Ah_NH_5ovkjv12j3p_Ct_V21_U_3e078d9b3e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

