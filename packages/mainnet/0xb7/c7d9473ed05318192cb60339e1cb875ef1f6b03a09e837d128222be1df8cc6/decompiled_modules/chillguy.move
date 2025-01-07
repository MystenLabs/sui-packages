module 0xb7c7d9473ed05318192cb60339e1cb875ef1f6b03a09e837d128222be1df8cc6::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGUY>(arg0, 6, b"CHILLGUY", b"Just a chill guy", b"I know Im supposed to be a chill guy and low-key not really care about anything but Im tired of trying to be someone that Im not I want you to think of something right now that makes you happy that thing you see the thing that lights you up, Chase that all of your soul chase that because its easy to brush off lifes potential and Im not trying to say that life is easy. In fact Id argue that the only way that something is meant to be if youre willing to commit to the difficulty in life otherwise it wasnt meant to be anything but just a missed opportunity it will be a difficult road but heres what we come to learn everything of value is difficult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Fy59_T_Mn_Lb4j_Gg_L6_Lpquy_X_Sx_TRXKR_4m_Ef_Sob_U_Ss_Po_R46_cf0de0dc16.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

