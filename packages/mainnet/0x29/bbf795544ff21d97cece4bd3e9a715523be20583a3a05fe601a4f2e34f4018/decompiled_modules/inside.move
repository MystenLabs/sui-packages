module 0x29bbf795544ff21d97cece4bd3e9a715523be20583a3a05fe601a4f2e34f4018::inside {
    struct INSIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDE>(arg0, 6, b"INSIDE", b"INSIDE CRYPTO", b"First emotion coin on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd1o_Uyq_A_Xs_Yirpc_Xq8_Xe_PUL_Nw_Cp_VWEL_2_Y5_DYABZ_Rz4_Vf_H_b0db66b328.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

