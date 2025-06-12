module 0x4dc7d1b59eed0de73f581f7e0c6177edb5cf6efe7886ae261a6eeb27fe2c7ecc::hello_world {
    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO_WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO_WORLD>(arg0, 9, b"HW", b"hello world", b"hello world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/dbaea9b2-d4d5-4022-9af2-81a000818aeb.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_WORLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO_WORLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

