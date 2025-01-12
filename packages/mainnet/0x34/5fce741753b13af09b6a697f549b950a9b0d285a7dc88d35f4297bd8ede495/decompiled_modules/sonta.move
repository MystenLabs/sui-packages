module 0x345fce741753b13af09b6a697f549b950a9b0d285a7dc88d35f4297bd8ede495::sonta {
    struct SONTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONTA>(arg0, 6, b"SONTA", b"sonta clauz", x"4e4f542054484520425249474854455354205354415220494e20544845204e4f5254480a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_C_Ac_A3r66kz_X7_HQZH_1b_RCD_2eut_Fwn_Wt_Nbpqba_FN_Rphr_K_8d26243c80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

