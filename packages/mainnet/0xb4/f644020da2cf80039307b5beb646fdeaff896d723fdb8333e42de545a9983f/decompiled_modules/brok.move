module 0xb4f644020da2cf80039307b5beb646fdeaff896d723fdb8333e42de545a9983f::brok {
    struct BROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROK>(arg0, 6, b"BROK", b"Grok's Retarded Brother", b"Meet Brok, Grok's retarded AI brother.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaa_Tq4_Wus4_X2_UXWKQ_Kaq_J_Cx6r_QCFF_Jnuou9x_B_Mmxw_KU_4_L_c38b4b22ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

