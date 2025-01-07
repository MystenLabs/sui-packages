module 0x264cc4da6c2713d9cc65d7629e9046a35d4314ebb5c4b86e09ee6b9536153b57::manyu {
    struct MANYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYU>(arg0, 6, b"Manyu", b"littlemanyu", b"The most pampered Shiba Inu on the internet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SH_6y_Jkq3_Yu92jyn_Feb5_Crk5cf_P_Xd3w_T_Hz2g_Pmh_J_Vs_Hi_M_2f23c3ad85.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

