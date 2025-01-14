module 0xee653f968c9d8f08294231eca562153134e1a5a57efa63a5776a6ab69a9a7151::suibapeai {
    struct SUIBAPEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIBAPEAI>(arg0, 6, b"SUIBAPEAI", b"SUIBAPEAI by SuiAI", b"SUIBAPEAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7_G5gwo_Y_Njgx1z_BX_8ga_A3fepf6oapd7u_N_Luys8ga9rk_Vu_93a284a39f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBAPEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAPEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

