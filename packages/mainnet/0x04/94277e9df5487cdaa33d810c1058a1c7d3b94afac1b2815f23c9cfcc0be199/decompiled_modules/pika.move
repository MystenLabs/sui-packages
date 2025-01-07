module 0x494277e9df5487cdaa33d810c1058a1c7d3b94afac1b2815f23c9cfcc0be199::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"PIKA", b"PIKA ON SUI", b"https://x.com/b1ackd0g/status/1814721728788242916?s=46&t=zsEjvpTJUys8dcZz9NUgLQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5874495247174_4215ffcdab0c2689e47733e56a06ab61_5db431f057.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

