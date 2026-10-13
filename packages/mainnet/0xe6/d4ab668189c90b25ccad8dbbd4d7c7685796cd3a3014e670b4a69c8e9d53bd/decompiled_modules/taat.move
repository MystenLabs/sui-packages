module 0xe6d4ab668189c90b25ccad8dbbd4d7c7685796cd3a3014e670b4a69c8e9d53bd::taat {
    struct TAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = x"6ec3a972616174";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"daaez";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<TAAT>(arg0, 6, b"TAAT", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/QKlGO9XvqLFG34ip")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

