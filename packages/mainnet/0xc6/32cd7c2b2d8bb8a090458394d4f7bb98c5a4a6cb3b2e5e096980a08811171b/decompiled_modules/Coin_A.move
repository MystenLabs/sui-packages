module 0xc632cd7c2b2d8bb8a090458394d4f7bb98c5a4a6cb3b2e5e096980a08811171b::Coin_A {
    struct COIN_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_A>(arg0, 9, b"COINA", b"Coin A", b"Coin A Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3PFJ4XYGB303H01NH6M5DYG.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_A>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

