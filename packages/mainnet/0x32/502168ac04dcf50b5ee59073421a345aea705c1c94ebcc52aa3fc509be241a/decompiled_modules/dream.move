module 0x32502168ac04dcf50b5ee59073421a345aea705c1c94ebcc52aa3fc509be241a::dream {
    struct DREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAM>(arg0, 6, b"DREAM", b"@dream", x"4d696e6563726166742073747566662c207965732c206d792049474e20697320447265616d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmabbwc_F_Zb2_L4_L9x4_Mxgu_F_Rs_Xe_XM_Gadjpj_RG_Bt_Y_Be4_Vmq_L_e1dd220414.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

