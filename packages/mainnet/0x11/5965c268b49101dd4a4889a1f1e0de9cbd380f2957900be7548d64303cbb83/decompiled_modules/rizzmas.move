module 0x115965c268b49101dd4a4889a1f1e0de9cbd380f2957900be7548d64303cbb83::rizzmas {
    struct RIZZMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZMAS>(arg0, 6, b"RIZZMAS", b"Merry Rizzmas!", x"4d657272792052697a6d61737320746f20616c6c205375692062656c6965766572732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b1e_Lj_Eycer_B4_Cpywf2_Zda_CG_5_R_Yf2_VWN_9xp_RD_Zu5ekv_P_0301888163.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

