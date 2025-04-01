module 0x54b39b517f0f86e46183b7deaa89518a82f728d57cc0da7d267b3bbe3842b7b6::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"SUIII", b"suiii", b"suiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/my_character_4afb9d66fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIII>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

