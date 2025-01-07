module 0xb60f8ef022f47840c10c25be8010c0c9e68f115dc219b5dd15d931f949fb232d::gpeng {
    struct GPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPENG>(arg0, 6, b"GPENG", b"GANGSTA PENGUIN", b"Gangsta Penguin on Sui Chain ! Check It and Dyor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6f_Pm_Kh_M_Mrb_SFZB_Fot_Kiw_X6_A_Yzb_X_Etcsa_Dd_WVRV_9wpump_573b8313c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

