module 0x219d49c24777c696205f2262bf1c673a01c08d3126961f3005a841ffd6dc1880::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 6, b"HODL", b"Just Diamond Hands", x"4a757374204469616d6f6e642068616e6473206e6f7720676f2024484f444c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S_Td_Y_Zh_L_Yk_L3_Ak_WR_Yt_TL_Lf_E61o_Ms_Z9_Crc_Mxnxvosbe_Un5_424ffcb9c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

