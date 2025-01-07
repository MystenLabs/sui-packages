module 0x9b11758d077d99a4f11328b5f7fd3dc86fee0b1f4fa57324720f9b668d1532b5::loading {
    struct LOADING has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOADING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOADING>(arg0, 6, b"LOADING", b"loading AI", b"Transforming loading screens into mini adventures because your time deserves more than a spinning wheel! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YV_Pyb_Je8u_Z8_KVF_9wu_Y_Zfbaj_E2_Jh3_A_Hm_F_Arn_U_Sb_ZX_Eusv_2a866a5d12.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOADING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOADING>>(v1);
    }

    // decompiled from Move bytecode v6
}

