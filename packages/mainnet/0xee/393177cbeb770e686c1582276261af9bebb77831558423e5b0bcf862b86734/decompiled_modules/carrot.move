module 0xee393177cbeb770e686c1582276261af9bebb77831558423e5b0bcf862b86734::carrot {
    struct CARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARROT>(arg0, 6, b"CARROT", b"Hunter vs Rabbit", b"Hunter vs Rabbit is a P2E (Play to Earn) game that anyone can play! You can choose your ownlevel of risk, allowing for very low as well as very high investment possibilities. We are alsoimplementing innovative systems to give real and lasting utility to the $CARROT token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Axn_Wf_Tu_Kqayu_Zxha759_Yuid_Ai_QH_Sbdc_Fm_UP_5bo8gi_Gdp_43f757cd59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

