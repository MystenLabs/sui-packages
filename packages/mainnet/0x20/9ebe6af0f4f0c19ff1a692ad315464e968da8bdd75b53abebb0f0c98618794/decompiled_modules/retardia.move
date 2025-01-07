module 0x209ebe6af0f4f0c19ff1a692ad315464e968da8bdd75b53abebb0f0c98618794::retardia {
    struct RETARDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIA>(arg0, 6, b"RETARDIA", b"RETARDIA SUI", b"RETARDIA SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_Rr_Lhe_V7d_Sec_Vka3_Mfj_Yb4_Wa6_Z6ueg_Nyzhp_Fe_E_Rsf_FZP_2ff6d082d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

