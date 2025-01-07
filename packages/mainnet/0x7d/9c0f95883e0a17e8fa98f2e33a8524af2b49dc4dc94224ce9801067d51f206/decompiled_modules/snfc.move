module 0x7d9c0f95883e0a17e8fa98f2e33a8524af2b49dc4dc94224ce9801067d51f206::snfc {
    struct SNFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNFC>(arg0, 9, b"SNFC", b"SUI-NI-FI-CIENT", b"A touch of exclusivity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNFC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNFC>>(v2, @0xf277b30a98f62deabc45c27f9e1d68b8b6e2561b4dfdfb6afd091e0dc0229d5b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

