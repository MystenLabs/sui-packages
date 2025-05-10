module 0x40598bc63041fed9e5a0a3896531b4e0db6845c960c3e676b44e49f58d2cb24f::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"BaBy Pump", b"BaByPump", b"A fun meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.tusky.io/5ab323c3-19e1-48b1-a5e2-f01b2fb3a097")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, @0xc1f65b01785528768f04b433ee2e272aafdf6150e79ce10a6afceea52f9f21c6);
    }

    // decompiled from Move bytecode v6
}

