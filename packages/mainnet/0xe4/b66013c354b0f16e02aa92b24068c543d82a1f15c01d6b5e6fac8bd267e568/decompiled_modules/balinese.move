module 0xe4b66013c354b0f16e02aa92b24068c543d82a1f15c01d6b5e6fac8bd267e568::balinese {
    struct BALINESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALINESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALINESE>(arg0, 6, b"BALINESE", b"Balinese Monkey", b"$BALINESE - the memecoin where a selfie-snapping, middle-finger mastro from Bali is flipping the script on finance. Get ready for some monkey business!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_C6e_Lz_L_Rk_GVRYGZ_Hh_PTY_6_Wt4_N_Pygg_U4ub_Wjobe4_S_Yyi_K_14c8e669d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALINESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALINESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

