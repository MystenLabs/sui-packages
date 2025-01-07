module 0xa688f4b0f4494e80822b5141a0d308846caca129daebba55361717041347888a::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POS>(arg0, 6, b"POS", b"POPSUI", x"504f50535549204f4e204d4f564550554d50207c200a4061646f6265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme8_XUS_Fabe_TWG_Gy_Etusnmai_T65_Jm_Ar_JD_6f_MP_6at_E9_U_Hd_C_5a2e393906.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POS>>(v1);
    }

    // decompiled from Move bytecode v6
}

