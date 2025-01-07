module 0x75aba38d052434c8ff354a3ce45ebb1e90b7eaf1d105649722eef00d3662c93d::pumpeng {
    struct PUMPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPENG>(arg0, 6, b"PUMPENG", b"PUMP THE SUI DENG", b"MAKE SUI DENG TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_P85kkrvj_Eg_Aw92z_NF_Hq_EV_Adnqd1_T5_H_Sz61_W_Gqd_Jb_R_Uw_0abd944bbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

