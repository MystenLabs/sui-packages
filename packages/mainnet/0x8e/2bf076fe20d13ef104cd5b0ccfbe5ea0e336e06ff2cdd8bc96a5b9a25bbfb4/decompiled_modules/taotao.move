module 0x8e2bf076fe20d13ef104cd5b0ccfbe5ea0e336e06ff2cdd8bc96a5b9a25bbfb4::taotao {
    struct TAOTAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOTAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOTAO>(arg0, 6, b"TaoTao", b"Tao Tao", b"Tao Tao, the first Yangtze finless porpoise to be born in captivity, recently celebrated his 19th birthday with staff members at the Institute of Hydrobiology under the Chinese Academy of Sciences in Wuhan, Hubei province.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmep_QZLWAB_Ms8_V6_F4_Vt_Ew_L_Zjkvecf6h_L_Bm_R9v_V_Mx64s_Sqz_e49c832ed0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOTAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOTAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

