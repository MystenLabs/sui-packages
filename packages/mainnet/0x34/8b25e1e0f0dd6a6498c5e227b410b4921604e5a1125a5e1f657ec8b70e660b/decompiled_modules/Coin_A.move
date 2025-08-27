module 0x348b25e1e0f0dd6a6498c5e227b410b4921604e5a1125a5e1f657ec8b70e660b::Coin_A {
    struct COIN_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_A>(arg0, 9, b"COINA", b"Coin A", b"Coin A Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3PGJYP6YTMFW1S7VXJ8A7KP.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_A>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

