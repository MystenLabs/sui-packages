module 0x226e8226df0f57acdda0608342af4fa1c797ce6cdbec1649935711b886318e68::imagine {
    struct IMAGINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMAGINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMAGINE>(arg0, 6, b"IMAGINE", b"JUST IMAGINE", b"just imagine ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Y_Vy_Sr7voyc_JM_Yr_A6_GFBS_Ukf_AP_4u_D6h361_Tw_CX_Vo2b4_Q_9a70b3af59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMAGINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMAGINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

