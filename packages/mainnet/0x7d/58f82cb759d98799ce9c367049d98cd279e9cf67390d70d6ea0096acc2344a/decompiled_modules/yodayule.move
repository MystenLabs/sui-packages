module 0x7d58f82cb759d98799ce9c367049d98cd279e9cf67390d70d6ea0096acc2344a::yodayule {
    struct YODAYULE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODAYULE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODAYULE>(arg0, 6, b"YODAYULE", b"Yuletide Yoda", x"4272696e677320796f7520746964696e67732c20686520646f65732e20436c6f736520796f7572206368696d6e65792c20796f75206d757374206e6f742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_P3_Pcy_Yeth_BZ_Em_Fi_L_Awu_F_Wb4i_XEM_66o_Fq_Ro_Xv_Lmh_KY_3p_2b385429f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODAYULE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODAYULE>>(v1);
    }

    // decompiled from Move bytecode v6
}

