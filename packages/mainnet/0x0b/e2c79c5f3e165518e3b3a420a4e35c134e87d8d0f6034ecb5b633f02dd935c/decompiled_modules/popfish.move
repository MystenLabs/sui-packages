module 0xbe2c79c5f3e165518e3b3a420a4e35c134e87d8d0f6034ecb5b633f02dd935c::popfish {
    struct POPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFISH>(arg0, 6, b"POPFISH", b"Popfish", b"POP POP POP POP POP POP POP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0383_5ba80109b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

