module 0xabe4726b169d228280c21273b61218cb1a9057504e0db7ff236c69b64cc0436f::push {
    struct PUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSH>(arg0, 6, b"PUSH", b"PRAY UNTIL SOMETHING HAPPEN", x"5052415920554e54494c20534f4d455448494e472048415050454e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Nm_Z4k_S2_Sep_C43_P_Cp_ASX_74w5dfg_LG_Jj_Ey_Zr_ARKX_Fg_Xx_V_77aa203f93.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

