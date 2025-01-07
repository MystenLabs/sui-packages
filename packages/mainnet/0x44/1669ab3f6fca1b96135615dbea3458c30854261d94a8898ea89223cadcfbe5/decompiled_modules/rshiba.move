module 0x441669ab3f6fca1b96135615dbea3458c30854261d94a8898ea89223cadcfbe5::rshiba {
    struct RSHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSHIBA>(arg0, 6, b"Rshiba", b"Reddit Inu", b"rshiba the no.1 subreddit for Shiba Inus worldwide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Udmejc6_Qg_CCQX_2_G6gwwh_P5e_Ty_V5e_Q_Ge4_V_Yicy91_E24_Cu_8ca0834b67.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

