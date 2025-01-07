module 0x82f8ae611c118b43de3bcec636e0d0879fbe9766410531c0ced21575d800e548::milf6900 {
    struct MILF6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILF6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILF6900>(arg0, 6, b"MILF6900", b"Meme Index Liquidity Fund", b" MILF6900 SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Syrtut_YST_Sd_Qjt_Xno76h_MR_Tgumdw_K9c22sq_Qx_Sm_M4uv_J_1c4c5d563a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILF6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILF6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

