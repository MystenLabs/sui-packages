module 0xce7461f2c4a9fa25408c1aaf66a6987c2498c71b2698867e4ca919d0aeadb79f::suiaimeme {
    struct SUIAIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIAIMEME>(arg0, 6, b"SUIAIMEME", b"SUIAI MEME by SuiAI", b"SUIAI MEME Onchain AI Agents @Cryptonevis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_12_11_58_40_967c632c74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAIMEME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAIMEME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

