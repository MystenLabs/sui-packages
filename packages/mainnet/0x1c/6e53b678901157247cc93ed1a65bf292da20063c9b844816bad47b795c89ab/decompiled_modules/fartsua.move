module 0x1c6e53b678901157247cc93ed1a65bf292da20063c9b844816bad47b795c89ab::fartsua {
    struct FARTSUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTSUA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FARTSUA>(arg0, 6, b"FARTSUA", b"Fartsui by SuiAI", b"FartSUIai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Qm_Qr3_Fz4h1et_Ns_F7o_LGMR_Hi_Czh_B5y9a7_Gjyodn_F7z_LHK_1g_98c4190acb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTSUA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTSUA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

