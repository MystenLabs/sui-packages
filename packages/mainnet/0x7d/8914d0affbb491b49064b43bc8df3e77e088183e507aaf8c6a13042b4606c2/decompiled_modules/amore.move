module 0x7d8914d0affbb491b49064b43bc8df3e77e088183e507aaf8c6a13042b4606c2::amore {
    struct AMORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMORE>(arg0, 6, b"AMORE", b"Amocucinare", b"For those who love to cook ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T_Chav5osef_Kkxn_Zcsyq_Yq1_KF_3hho_Nrbbe7_P8_H8wm6_Dv_U_ddad8f4b45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

