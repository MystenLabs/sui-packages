module 0x165395ef1a4117e55d40d9d79239ca1a65ca517e4f48105d2571abc593337aaa::girl {
    struct GIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRL>(arg0, 6, b"Girl", b"Iranian Girl", b"This Iranian girl is a real feminist, she is fighting for womens rights against lslamic regime! Brave Iranian woman shows morality police that Iranian women are fed up with hijab, burka and Islam. Respect for her. She is one badass lady boss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vu3_Q3_K6siob6mm_NB_Sth88_Ch_Bt9z_Chd_TW_2c_TK_8gzo_Z_Fyy_5f11e76a3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

