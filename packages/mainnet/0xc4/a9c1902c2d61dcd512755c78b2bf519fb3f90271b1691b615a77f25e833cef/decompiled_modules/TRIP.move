module 0xc4a9c1902c2d61dcd512755c78b2bf519fb3f90271b1691b615a77f25e833cef::TRIP {
    struct TRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIP>(arg0, 6, b"TRIP", b"Trippi Troppi", b"Trippi troppi, troppa trippa, tre topi trotterellano tra tromboni tritati. Triplicando trottoline tropicali. E chi troppo vuole, nulla trippa!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmTq5BqGK4N4zcVwRoXsPWJyF24qBuiSXCpviddoA5HmZY")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

