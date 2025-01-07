module 0xc2499d2d776b80c5dfafd9c1bb3a3b605e963ab2e43d50d32c8b3aaa4b07452e::sendor {
    struct SENDOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDOR>(arg0, 6, b"SENDOR", b"Sendor", x"57656c636f6d6520746f2053656e646f722e2e2e204e6f206e65656420666f722066696e616e6369616c206164766963652c206a7573742053454e44206974210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Nc_Cz_L4_U51t_Xr_Lorsn_HR_Bu_Trdd3xy_Yood_SY_Em_JL_8vw_PZ_bdda56a3b7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENDOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

