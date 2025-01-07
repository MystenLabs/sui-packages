module 0x949a060a337129ef333aa01a0db9ee35ee757d44a56b1a61aac7e8ccdd24bb1d::mill {
    struct MILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILL>(arg0, 6, b"MILL", b"mili on sui", b"MILL MILL MILL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Pgi6vf_M_Evh_M_Yvppn_Xi_F_Kb_Mf_Cn_LC_82_MA_Pkcw_Vtk6sd_Va_f2b65a0149.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

