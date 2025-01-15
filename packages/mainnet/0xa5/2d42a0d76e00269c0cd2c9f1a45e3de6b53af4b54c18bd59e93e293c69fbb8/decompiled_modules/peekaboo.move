module 0xa52d42a0d76e00269c0cd2c9f1a45e3de6b53af4b54c18bd59e93e293c69fbb8::peekaboo {
    struct PEEKABOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEKABOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEKABOO>(arg0, 6, b"PEEKABOO", b"Peekaboo", b"Peekaboo....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ssk_Q6_Lbfmp7_E_Ur4_Jt_A_Bczsi_N6_Y6_N286_D_Ed_PYM_4_Ag82n_U_ba1bb7a7e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEKABOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEKABOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

