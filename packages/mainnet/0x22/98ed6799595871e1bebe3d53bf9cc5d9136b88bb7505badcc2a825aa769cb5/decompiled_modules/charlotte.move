module 0x2298ed6799595871e1bebe3d53bf9cc5d9136b88bb7505badcc2a825aa769cb5::charlotte {
    struct CHARLOTTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARLOTTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHARLOTTE>(arg0, 6, b"CHARLOTTE", b"Charlotte IA by SuiAI", b"Pushing the boundaries of artificial intelligence with quantum computing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/charloteee_14c0c838de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARLOTTE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARLOTTE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

