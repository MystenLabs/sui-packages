module 0x42d53f010c8c8eba1eb9acca40c542a3404bc87af0d10930aec5dba218c7251d::chuck {
    struct CHUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUCK>(arg0, 6, b"CHUCK", b"LUD CHUCK", b"Meet Chuck, a cloud that chases memes across the internet. he drifts through the online world, always catching the latest jokes and trends. Chuckls light-hearted nature makes him the perfect companion for any viral moment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_FN_7_AAQ_Nv_C_Ww34_RM_Spt2_JC_Cb_Jbx_Qv_Ny_Wcr_Gq_DL_3_Mff9r_b3bf484329.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

