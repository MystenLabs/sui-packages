module 0x2c1d8f1812e228b22b2feba0fff31ce3bdb77f83e12a536084623be5df32854d::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXI>(arg0, 6, b"MAXI", b"MAXIMILLION", b"First memecoin established and based on the same forum where Bitcoin was started by Satoshi: https://bitcointalk.org/index.php?action=post;msg=64437433;topic=5506486.0;sesc=cf3b1796557ddade59065273610ecbf4 Proof 1: https://bitcointalk.org/index.php?topic=5.msg28#msg28 Proof 2: https://bitcointalk.org/index.php?topic=5385493.msg59260958#msg59260958 No TG, No X, No website. Pure communication through the threads of Bitcoin's inception forum. Hold your bags and be prepated for the next $100 million+ memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_No9_X6sm_X_Uvpv3_Dv_Xu1n_L9t6_LMW_Rr_Tsohb_QN_9pm_Qq_Hbi_0729905a2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

