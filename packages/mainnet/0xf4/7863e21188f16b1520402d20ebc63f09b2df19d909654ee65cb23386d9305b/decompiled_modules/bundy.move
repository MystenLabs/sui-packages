module 0xf47863e21188f16b1520402d20ebc63f09b2df19d909654ee65cb23386d9305b::bundy {
    struct BUNDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNDY>(arg0, 6, b"BUNDY", b"bundy", b"Hi Im Bundy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcu_Hx_HGTU_2hgc_R7gmh_UD_1_Pt_N4y_Fm1_Mcvab81hf6_W3o_Z_Vx_0037f5e539.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

