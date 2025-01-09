module 0xe9899a6f55aeb554f88b043db03ed584ffe7416b58c8068915adfe328555d1ab::solai {
    struct SOLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOLAI>(arg0, 6, b"SOLAI", b"Solix Ai by SuiAI", b"This partnership brings Glacier Network's scalable, decentralized vector database into solid AI's infrastructure, enhancing data management for advanced SOLAI and crypto insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3_E2_AD_029_892_C_4_CCC_821_C_11_B72_C5_D369_F_fcfa42e083.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOLAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

