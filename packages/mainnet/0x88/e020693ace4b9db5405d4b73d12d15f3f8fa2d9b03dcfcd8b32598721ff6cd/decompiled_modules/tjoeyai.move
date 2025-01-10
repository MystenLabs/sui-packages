module 0x88e020693ace4b9db5405d4b73d12d15f3f8fa2d9b03dcfcd8b32598721ff6cd::tjoeyai {
    struct TJOEYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJOEYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TJOEYAI>(arg0, 6, b"TJOEYAI", b"TestJoey on SUI by SuiAI", b"test token for JOEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/joey_background_04a695777f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TJOEYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJOEYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

