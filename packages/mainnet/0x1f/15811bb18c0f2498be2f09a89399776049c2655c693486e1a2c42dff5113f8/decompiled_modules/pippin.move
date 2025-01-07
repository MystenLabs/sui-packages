module 0x1f15811bb18c0f2498be2f09a89399776049c2655c693486e1a2c42dff5113f8::pippin {
    struct PIPPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPIN>(arg0, 6, b"Pippin", b"Sui Pippin", b"Just a playful and whimsical little guy on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dfh5_Dz_Rg_Svv_CF_Do_Yc2ci_Tk_Mrb_Df_R_Kyb_A4_So_Fb_Pm_Apump_dfa41746cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

