module 0x3766e83a2a2eff147f3b6668643c1fb4f80e391b1013d4d744f9665a8f8d3a6b::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE by SuiAI", x"2453554920e2978f204149204167656e74205f2f20487970654167656e74206f6620245355492045636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/t_V_Jhz_N5_L_400x400_1_25fd84c4df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRISE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

