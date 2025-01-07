module 0xf286ad17d599979fa759da91990df93a4787a23fb491dc221109e8734a2a1470::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BabyAXOL", b"BabyAxol", b" Meet $BABYAXOL, the adorable little swimmer on #SUI ! dive deep and make waves together! Axol is my Dad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/att_g_Ufno8_Yod_Ag_Fqc_HE_0_H4sn_Enp5_AQB_7d_X4_Ka_Ur_Qo_VPSW_0_ezgif_com_resize_c72b8252e4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

