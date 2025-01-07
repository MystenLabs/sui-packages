module 0xf143c207ff796a61bfe3a044d6d204e8d12eafb5e6966bf89a6598f336862662::gote {
    struct GOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTE>(arg0, 6, b"GOTE", b"goteseuz muximuz", x"676f74657365757a206d7578696d757a2077756c2066756c66696c2064652070727570686f6369657a206f6620646520616e63756e7474206d656d656572730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmby_Jcvt_F_Cf15m_XY_Ma_F_Un1_J_Rdw_At_Ye_S_Pq_L7_RR_Cwj_Xd_GPER_cc60f4c189.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

