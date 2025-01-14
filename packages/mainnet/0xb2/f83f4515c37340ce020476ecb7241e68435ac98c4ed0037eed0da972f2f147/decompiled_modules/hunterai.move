module 0xb2f83f4515c37340ce020476ecb7241e68435ac98c4ed0037eed0da972f2f147::hunterai {
    struct HUNTERAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTERAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HUNTERAI>(arg0, 6, b"HUNTERAI", b"SUIHUNTERAI by SuiAI", b"SUIHUNTERAI It is the first autonomous monitoring vehicle. Its mission is to identify and monitor the best performing wallets. Hunter will own his own trading wallet and make his own choices to grow that capital.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7_Z_Ah_WFM_Yb_Kv_Maorsh_Bz_L91m_U_Hw_Af6w9_P64huwc8dpump_8f68d7dc92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUNTERAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNTERAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

