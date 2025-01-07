module 0x5f2057cc7de935d89ae4d78d8dbbd1c864630a1502a9b00bc2317b410482508e::acb {
    struct ACB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACB>(arg0, 6, b"ACB", b"Ancy Butt", b"Ancy Pelosis Butt Pic ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Tm_Y_Ec_FJ_Pa_N_Pm5_G72_V54_GW_Qdcf_JES_Ed_Pc_Sfw_G_Em_Htt5_T_32d352d5f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACB>>(v1);
    }

    // decompiled from Move bytecode v6
}

