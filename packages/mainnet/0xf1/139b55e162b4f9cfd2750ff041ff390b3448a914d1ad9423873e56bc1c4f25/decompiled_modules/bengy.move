module 0xf1139b55e162b4f9cfd2750ff041ff390b3448a914d1ad9423873e56bc1c4f25::bengy {
    struct BENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENGY>(arg0, 6, b"BENGY", b"Bengy", x"48492c20494d202442454e4759212050454f504c452054454c4c204d452049204c4f4f4b204c494b4520504550452e20492054454c4c205448454d20494d20412050454e4755494e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y9x_Go_FHZ_7_Fs_P_Jy_Rnfxu_K7s_Jv_Ve_Wao_HRU_5mjzd_YA_Du_TAA_f76db5a44d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

