module 0x148157089d090d0089c25a9ad18225147a219ea7a5e8e898534e1948cce5e043::taylor {
    struct TAYLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAYLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAYLOR>(arg0, 6, b"Taylor", b"Taylor on sui", b"Where Feline Flair Meets Crypto Cool!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcct_Z_Wpy_Kd_XXC_4_A9_WDSHM_Qx_N9type_X6z8_Pwn_R_Xw_HEU_8_RU_4d9401612a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAYLOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAYLOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

