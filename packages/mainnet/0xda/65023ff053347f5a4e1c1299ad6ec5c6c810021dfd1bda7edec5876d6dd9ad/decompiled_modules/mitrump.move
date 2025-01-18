module 0xda65023ff053347f5a4e1c1299ad6ec5c6c810021dfd1bda7edec5876d6dd9ad::mitrump {
    struct MITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MITRUMP>(arg0, 6, b"MITRUMP", b"TRUMP MITA by SuiAI", b"The most handsome president of usa.But what could this girl be hiding underneath?.Or a boy?.MiSide is an anime-style adventure computer game with horror elements from Russian indie developers AIHASTO. The game was released on December 11, 2024[. In the story of MiSide, the protagonist moves inside a mobile game about a girl named Mita.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/trumpmita_9db86c0c8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MITRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

