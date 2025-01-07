module 0xbe51df4eb6475356f7a3b0feb55b228ce73b6c21d94dce44e430e0ed32db2188::wibi {
    struct WIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIBI>(arg0, 6, b"WIBI", b"WIfbbit", b"Wifbbit got involved in the cryptocurrency market through memecoins on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Un_G_Vy_E_Dt8qm_Br_Ggn2_Fmochz_ZZT_2_H1_V1_PZ_Ua_Xas2n3_J_Pm_a5cea7abcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

