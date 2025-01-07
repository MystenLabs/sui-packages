module 0x3edbbc9b61b3119ce617cdfcd51471d4a3a68598cc83c4181de258fa7a12e106::gcp {
    struct GCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCP>(arg0, 6, b"GCP", b"Grumpy Crypto Panda", b"Grumpy Crypto Panda TO THE MOOON! Back up by an experienced team who achieved good milestone on previous project.Before you buy, Check CA!!!!!DEV is not bot or scam.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcj_Hx_L9xg_Wkti_K_Bv_TT_7_Eh_N_Dprz1_P_Mre_Gh_UHSC_5_Wmf_Ljxx_65bfe1cbf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCP>>(v1);
    }

    // decompiled from Move bytecode v6
}

