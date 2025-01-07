module 0x241b9c0e69d3f9e18f1d5b07619bf011754ffdd782f6a876fc5884c36ce32fcf::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAME>(arg0, 6, b"GAME", b"Generate Assets Make", b"Generate Assets, Make", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Utj_V7_R29_Wy8m_D_Za_BESUJQD_Py_P_Tiudvo6_YZ_45_Ckejze1_bb1f47672b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

