module 0x22af8a636edc51a8ffe230e14edf7f57440f08696022d8c8b500a0586edaae8::qbist {
    struct QBIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: QBIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QBIST>(arg0, 6, b"QBIST", b"QUADROBISTS", b"People in animal masks use this coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vh_WV_Cfoikrj986_REE_Thq3x81_Vm12_Z6_Bb_U_Rt_Ez_Aoa_Z6b_A_a8d2a6d8ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QBIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QBIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

