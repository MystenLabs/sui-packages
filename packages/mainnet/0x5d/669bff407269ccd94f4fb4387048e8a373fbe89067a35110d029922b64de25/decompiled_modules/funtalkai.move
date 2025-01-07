module 0x5d669bff407269ccd94f4fb4387048e8a373fbe89067a35110d029922b64de25::funtalkai {
    struct FUNTALKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNTALKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNTALKAI>(arg0, 6, b"FUNTALKAI", b"Funtalk AI", b"Connect with your perfect AI lover now with our great project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_EBS_Cruw73oj_DDP_Ly9b_Q_Gm_T_Jfq_Zqsev_Bs_Xat_Q_Yqyvkvc_fb696eeacf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNTALKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNTALKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

