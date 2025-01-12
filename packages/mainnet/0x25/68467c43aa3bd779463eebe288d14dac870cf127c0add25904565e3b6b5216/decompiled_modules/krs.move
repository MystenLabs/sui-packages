module 0x2568467c43aa3bd779463eebe288d14dac870cf127c0add25904565e3b6b5216::krs {
    struct KRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRS>(arg0, 6, b"KRS", b"Kores", b"Its a new time AI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YLS_1_V_Xu_Zk2v3_VF_Qu3u_Xtu99_WCZ_Rys_Xdze_Z_Mn_W7_VL_Ai_KU_38182bdc3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

