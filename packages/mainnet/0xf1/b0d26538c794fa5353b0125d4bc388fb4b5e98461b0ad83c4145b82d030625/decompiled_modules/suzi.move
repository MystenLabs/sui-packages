module 0xf1b0d26538c794fa5353b0125d4bc388fb4b5e98461b0ad83c4145b82d030625::suzi {
    struct SUZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUZI>(arg0, 6, b"SUZI", b"SuziKolAI by SuiAI", b"The First Ai Agent Kol in suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/D_5v_Vnmd_400x400_376d71c97d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUZI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

