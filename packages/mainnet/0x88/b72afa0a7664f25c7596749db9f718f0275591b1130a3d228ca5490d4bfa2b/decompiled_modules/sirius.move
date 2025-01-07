module 0x88b72afa0a7664f25c7596749db9f718f0275591b1130a3d228ca5490d4bfa2b::sirius {
    struct SIRIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRIUS>(arg0, 6, b"Sirius", b"First reply", b"First Cat In Crypto First reply on bitcoin forum This is Sirius", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_T44rfi9_BD_Ud_Zb_Ev_Vdd_ZW_Vfs_Grp_C6_N1s_SSK_Yn_Cs_Lpump_74a900abb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIRIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

