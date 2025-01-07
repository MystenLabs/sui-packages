module 0x76b83efd87e7315b92c7c1f96ee805a3308fbc12b441536753adfab3a9cb64af::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"FROG SUI", b"FROS IS THE FEARLESS SuiS PET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbx8_QR_7_XAHA_2i5_Q_Sa6mg_J7k_Z_Ur_A_Maw9_R_Ut_Hr_D5_Jf_KL_Ubx_65faa8e368.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

