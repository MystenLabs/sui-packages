module 0x8d7fce945d2f5c57af7ebc0b3ec0f9c50e4705eb7d01543a2670631fecf9db7c::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 6, b"MIHARU", b"smiling dolphin", b"Miharu the cute dolphin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6t_VZ_Vjcpp_H2_BZ_9_Xj5y_FU_1_Zt34m2r_Ycy_Dqqp_Se_MD_Zpump_21a3b90e27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

