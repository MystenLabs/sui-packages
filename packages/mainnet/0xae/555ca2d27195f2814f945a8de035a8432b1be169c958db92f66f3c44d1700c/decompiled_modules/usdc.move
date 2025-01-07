module 0xae555ca2d27195f2814f945a8de035a8432b1be169c958db92f66f3c44d1700c::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC Meme", b"Buy 1 Sui worth of this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_H5_Rmo_S4_PQS_8_L_Tm_E_Sw_Q_Pc_KT_2_Xgw_U_Pz_Dm_T17_WDLT_Ad_Rk_W_8a6e627386.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

