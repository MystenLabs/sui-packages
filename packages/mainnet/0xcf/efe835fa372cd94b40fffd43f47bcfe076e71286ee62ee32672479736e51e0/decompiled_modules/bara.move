module 0xcfefe835fa372cd94b40fffd43f47bcfe076e71286ee62ee32672479736e51e0::bara {
    struct BARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARA>(arg0, 6, b"BARA", b"Bara on sui", b"SUI memecoin hero battling shitcoins. Loves ramen and justice. Fists up, belly out  it's $BARA time! Check out our website at bara-sol.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nx2njr_K3_YK_Has9_WPBE_3_Yo3_Cqz_Y1t_YMJE_Qs_N_Xb8q_Nr_Vr_E_cb3b32dce7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

