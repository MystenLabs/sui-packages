module 0xcb63b7dcf5f068b2241ed6ba2dfdaf44968a2a4cd6776ae79afbbfa262d4bf9c::suiky {
    struct SUIKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKY>(arg0, 6, b"SUIKY", b"SUIKY THE DUCK", b"QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK QUACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ccc_ed4f767516.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

