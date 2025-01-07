module 0xa947114a5bf6b1d3d8e449fd35c4bf518dece03ed7a9f1a024effd73d8267795::suidj {
    struct SUIDJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIDJ>(arg0, 6, b"SUIDJ", b"SUIDJ by SuiAI", b"SUIDJ is an innovative AI-powered music agent built on the SUI blockchain. It provides users with personalized music recommendations, real-time DJing capabilities, and seamless integration with blockchain features like NFT-based playlists and royalties tracking. SUIDJ uses advanced machine learning to adapt to individual tastes, making it the ultimate companion for music lovers and creators alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUIDJ_1edc49f025.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDJ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDJ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

