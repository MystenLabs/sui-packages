module 0x6609cc1d3035a067c3aa06e5482b83c99f8c2d9db597952bd7b2dc62e530640c::miladyterminal {
    struct MILADYTERMINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILADYTERMINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILADYTERMINAL>(arg0, 6, b"MiladyTerminal", b"Milady Terminal", b"Milady Terminal - Make Terminals Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae562967ac9f83b313846ae467bd0d95627e2f95_f3fe0a430c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILADYTERMINAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILADYTERMINAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

