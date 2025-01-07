module 0x3f9193eee0df4407756f5eedeea1820c72c15517ab1d87edeebb3d9b7ec4bd80::fatmas {
    struct FATMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATMAS>(arg0, 6, b"FATMAS", b"Fartmas Doge", x"54686520436f696e205468617473204c69676874696e672055702074686520486f6c69646179732c204f6e6520546f6f7420617420612054696d65210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf8ojmd_B3ih9p_G9_V_Wp_P1_Y5_Kj_Q_Nuj_C1_Ztrp_Za_Nwrp_A2_Gqx_47f02f629d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

