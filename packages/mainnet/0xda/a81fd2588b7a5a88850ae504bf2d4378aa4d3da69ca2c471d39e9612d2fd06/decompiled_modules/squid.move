module 0xdaa81fd2588b7a5a88850ae504bf2d4378aa4d3da69ca2c471d39e9612d2fd06::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"Sigma Squidward", b"#SQUID  - The Last Son of Moai Land", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2cja_Cct_Nhb_Bf_Mq_Wz1_Axbu_Yqq_Ukb_P1_E_Ht_Mr_Xy_Ug_Q_Ypump_ac37b008ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

