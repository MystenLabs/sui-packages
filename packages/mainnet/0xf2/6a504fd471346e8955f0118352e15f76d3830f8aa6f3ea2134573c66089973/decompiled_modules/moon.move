module 0xf26a504fd471346e8955f0118352e15f76d3830f8aa6f3ea2134573c66089973::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"MOON SUI", x"43525950544f20544f20544845204d4f4f4e2026204245594f4e443a2068747470733a2f2f7777772e6d6f6f6e7375692e66756e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_c2d531703c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

