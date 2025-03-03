module 0x82ecb1d4e21e00cd3b59b7e46f46f6a83d5595349f84c6da72dd9e4214bb4480::zele {
    struct ZELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELE>(arg0, 6, b"ZELE", b"ZELENSKYY", b"Who could lead Ukraine if Zelenskyy resigns?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_V_Jg_Nj_UFRJW_8_Ssj_N_Fd_W_Wn_D_Sm_Fqmioyjt_N_Cfuw_Ljvpump_3d5cf17170.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

