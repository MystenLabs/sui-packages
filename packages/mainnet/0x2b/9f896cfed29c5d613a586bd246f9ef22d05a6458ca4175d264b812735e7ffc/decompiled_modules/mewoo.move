module 0x2b9f896cfed29c5d613a586bd246f9ef22d05a6458ca4175d264b812735e7ffc::mewoo {
    struct MEWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWOO>(arg0, 6, b"Mewoo", b"The Halloween Cat", b"The most famous halloween cat on TikTok.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VA_Ne3_AGM_Ehe3gvz_Et_Tz_E_Mx_H_Sx1f9p_U3v_Habngsn_Vb_Afv_6f3f9fce27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

