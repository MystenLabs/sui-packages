module 0xcc9ff9d7a3fa6187e0d97d29f8c6d4d27ff2ee468b6e5222db934d2afa1eed31::mewoo {
    struct MEWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWOO>(arg0, 6, b"Mewoo", b"The Halloween Cat", b"The most famous halloween cat on TikTok.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VA_Ne3_AGM_Ehe3gvz_Et_Tz_E_Mx_H_Sx1f9p_U3v_Habngsn_Vb_Afv_726d651583.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

