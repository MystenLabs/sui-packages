module 0x57747ffdd99ef83ff6f2d9635b6a304fd6aafa0afc328a2ff4d54089c69eafb6::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"BaBy Pump", b"BaByPump", b"A fun meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.tusky.io/5ab323c3-19e1-48b1-a5e2-f01b2fb3a097")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, @0xf0feaa6391efbbbf9064f725eb77949ddd016167feb83b7d9fbbf5694a936cae);
    }

    // decompiled from Move bytecode v6
}

