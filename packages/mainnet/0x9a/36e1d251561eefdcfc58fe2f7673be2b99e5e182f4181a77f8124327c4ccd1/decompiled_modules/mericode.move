module 0x9a36e1d251561eefdcfc58fe2f7673be2b99e5e182f4181a77f8124327c4ccd1::mericode {
    struct MERICODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERICODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERICODE>(arg0, 6, b"Mericode", b"mericode", x"4469676974616c205472616e73666f726d6174696f6e20426567696e73207769746820436f64650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Znatx_Km85_Xm_Nie4_Q6_Rub_AZ_Gnzi_L_Kv_Apy5e_NG_Mi_HW_Qy9_S_608f2e71ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERICODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERICODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

