module 0x12b59298d1bf1d7e5fe76b745f717c39ae446dcd14b7e6d5ea50c3a837d1a0ec::cp {
    struct CP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CP>(arg0, 6, b"CP", b"CHAMPAGNE PEPPY", x"4368616d7061676e6520646164647920706570650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xae_Zvo_By_SV_Ds_Dn2_X9e_TG_Pj_Sm_Pad_Cyjnbxy_YP_Ycz_UMN_68_df573eaefa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CP>>(v1);
    }

    // decompiled from Move bytecode v6
}

