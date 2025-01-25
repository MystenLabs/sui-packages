module 0xcf89c612e6fa9f127066e766fd32d8f10afc8e50787b2abf6474a8b60fe8efbb::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATAI>(arg0, 6, b"CATAI", b"Cat AI Sui Network by SuiAI", b"The AI Meme Token for the Community on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/O_Jyp_Rxu1_400x400_8a3dfa2087.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

