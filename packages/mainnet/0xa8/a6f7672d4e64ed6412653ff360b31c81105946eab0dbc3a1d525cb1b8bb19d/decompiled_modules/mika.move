module 0xa8a6f7672d4e64ed6412653ff360b31c81105946eab0dbc3a1d525cb1b8bb19d::mika {
    struct MIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKA>(arg0, 6, b"MIKA", b"MIKASUI", b"Meet Miko, the curious and playful cat who explores the digital world with elegance. Always one step ahead, Miko is known for her quick thinking and graceful moves, ensuring everything in the Sui Network runs smoothly with a touch of charm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_10_02_100940_d985d1b648.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

