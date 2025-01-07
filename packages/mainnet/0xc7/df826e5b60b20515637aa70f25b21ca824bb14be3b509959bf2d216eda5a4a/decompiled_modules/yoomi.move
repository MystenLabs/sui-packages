module 0xc7df826e5b60b20515637aa70f25b21ca824bb14be3b509959bf2d216eda5a4a::yoomi {
    struct YOOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOOMI>(arg0, 6, b"YOOMI", b"Yoomi on Sui", b"Hi, my name is Yoomi. I come bringing abundance for you all on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Pzrc_Y6536t_No_Wi_F1_Mwm_My_Y7h_Abm_Jn44vx_PCF_Fp9pump_0401ea31fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOOMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

