module 0x204a9fbd475223473b1366a46f3280bf3f0275a4a2284de38a90f9c01c538be7::magism {
    struct MAGISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGISM>(arg0, 6, b"MAGISM", b"Magnetism", b"Magnetism the chart. fuck it only pump !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme2_P_Nua_Gin3p_FJW_3_Ewhud5_Chy_Pvb_K_Sjug5_Tmqsqf9_E3v_T_5057b18712.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

