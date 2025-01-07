module 0x472852a7ec648075c98aa1f8701672bb9edddd7ff883a83258f6f8fb3e2a9a41::mcaga {
    struct MCAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAGA>(arg0, 6, b"MCAGA", b"McAmerica Great Again", x"244d634147412069732061206d6f76656d656e74207765726520446f6e616c64205472756d7020616e6420456c6f6e204d75736b20537570706f7274696e672065616368206f7468657220746f204d616b6520416d657269636120477265617420416761696e2c20776520616c6c2063616e20736179202249276d206c6f76696e27206974220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pa_W_Zp4w9_B_Bg_BZ_9_P_Qr_TRZ_Xg_A_Lr_P48f_V8_Pk_Crr_Rk_GA_5_Api_b540cc7fca.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

