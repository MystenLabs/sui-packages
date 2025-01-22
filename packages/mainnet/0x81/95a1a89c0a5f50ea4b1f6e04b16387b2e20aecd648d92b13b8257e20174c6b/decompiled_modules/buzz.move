module 0x8195a1a89c0a5f50ea4b1f6e04b16387b2e20aecd648d92b13b8257e20174c6b::buzz {
    struct BUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BUZZ>(arg0, 6, b"BUZZ", b"Hive AI by SuiAI", b"Simplifying DeFi through composable on-chain AI agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/f_Dd5t_Y_Ze_400x400_a1e72339dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUZZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

