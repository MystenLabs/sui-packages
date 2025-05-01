module 0x2dc64bd25cf0a4aef47f9374b1a6221cde8ede0bd3d81e5466328c58a5adb217::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SUIDUCK", b"SUIDUCK POKEMON", x"5375696475636b20697320746865206e65772053554920506f6b656d6f6e206f6e207468652053554920636861696e21205375696475636b206973207468652053554943554e45275320667269656e642e204c45747320676f207769746820686520746f206d696c6c696f6e73210a4e6577206d657461202c2053554920504f4b454d4f4e53210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_18_200346_08b5d97d22_507d7fc8e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

