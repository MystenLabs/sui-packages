module 0x4b29b407aa0024a01981c285dab6f2e3eb80966e6c2ab9629d7367398d735277::wdeng {
    struct WDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDENG>(arg0, 6, b"wDENG", b"wrapped Deng", b"Wrap Yourself in Fun with Wrapped Deng!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_C_Sbp_L_Fco_DX_Sg_HR_Zjs_A3sxe_Pz9_BI_8_Dy_Otc_H_o_Hh_Uqw_8b6813ab34.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

