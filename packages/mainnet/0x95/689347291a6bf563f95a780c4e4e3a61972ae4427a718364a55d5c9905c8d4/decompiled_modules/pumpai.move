module 0x95689347291a6bf563f95a780c4e4e3a61972ae4427a718364a55d5c9905c8d4::pumpai {
    struct PUMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPAI>(arg0, 6, b"PumpAI", b"Pump", x"54686520756e6f6666696369616c2041492076657273696f6e206f662050756d702e66756e2c2074686520667574757265206f662053554920546f6b656e204465706c6f796d656e74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yn6th_J39_BFBA_3vtr_C1n_Cge8_Xqarq_F2_Caf9p_N_Cq_Eh_H8hy_8372c57b7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

