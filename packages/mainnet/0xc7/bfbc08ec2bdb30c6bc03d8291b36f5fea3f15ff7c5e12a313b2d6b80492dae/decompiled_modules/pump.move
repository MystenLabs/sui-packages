module 0xc7bfbc08ec2bdb30c6bc03d8291b36f5fea3f15ff7c5e12a313b2d6b80492dae::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"Just Pump It", b"Just Pump It!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Wa_D1anh_Vhh_EKZP_2_NAC_Ehgb42c7y2y_A5_X_Fw_FPW_Fn_G_Nd_M_317b87bfcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

