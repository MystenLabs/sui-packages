module 0xca0b3f674401c1d2e5703f7bba9a2b633f37e22d4fe85de9745177577e27ca2d::nar {
    struct NAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAR>(arg0, 6, b"NAR", b"Naruton", b"Hey, shinobi! Its your future Hokage, Naruton! Were about to bring some ninja power to the crypto world. Believe it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3134_ffaafb0328.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

