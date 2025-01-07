module 0xa7749c6e9540d1496dd2380924d97ea8f62d27a403bbfbaa9ddb3dcfd15852dd::bonzi {
    struct BONZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONZI>(arg0, 6, b"Bonzi", b"Bonzi Buddy", b"BONZI Buddy on Solana. Reviving an early virtual assistant software from the internet jungle of the 2000s.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_S8_Q_Qq_V8f6qtf_Bm6n_F69og_Syzr_Vqq_Lev6_Da9_S_Dxk_Fo_Xr_f1e3b28679.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

