module 0x21b427d94321f380115424ae908543eea5bf87280f0c684d0779bc5e55e7b46b::nota {
    struct NOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTA>(arg0, 6, b"NOTA", b"NOTAS", b"SUINOTA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma9om_Lv_K_Hh2_Fx_Gryjn3c_Sz6_Z_Bx_N_Cq_Ve_Qyb2_Dpfou_Qc_Uh_E_cda88a2eb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

