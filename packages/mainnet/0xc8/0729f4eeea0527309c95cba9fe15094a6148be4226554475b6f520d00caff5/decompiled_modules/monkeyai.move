module 0xc80729f4eeea0527309c95cba9fe15094a6148be4226554475b6f520d00caff5::monkeyai {
    struct MONKEYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MONKEYAI>(arg0, 6, b"MONKEYAI", b"MONKEYAI by SuiAI", b"Get ready to level up with the agent made for gamers & game builders, powered by the SUIAI Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rmyh_T2_DH_2_Z7_QL_96_Wclv_W9_GOM_Io_1dbb0e15c8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONKEYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

