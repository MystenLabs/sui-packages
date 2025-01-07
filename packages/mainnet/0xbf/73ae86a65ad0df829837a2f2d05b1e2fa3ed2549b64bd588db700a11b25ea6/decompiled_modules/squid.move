module 0xbf73ae86a65ad0df829837a2f2d05b1e2fa3ed2549b64bd588db700a11b25ea6::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"Squid Game", b"nspired by the gripping South Korean series, our token incorporates the intense drama of Squid Game, bringing you into a world of financial challenges, strategic gameplay, and heart-pounding excitement.  Join us and be part of the Squid Game-inspired revolution on the SUI chain. It's not just a token; it's an experience! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SQUIDGROW_T_Rnhv_E_4x_Yq_R_Ai_L_Hsg_W_85a274857a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

