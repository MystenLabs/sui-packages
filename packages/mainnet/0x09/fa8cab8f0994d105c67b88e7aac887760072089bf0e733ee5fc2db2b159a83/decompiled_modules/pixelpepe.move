module 0x9fa8cab8f0994d105c67b88e7aac887760072089bf0e733ee5fc2db2b159a83::pixelpepe {
    struct PIXELPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXELPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXELPEPE>(arg0, 6, b"PixelPepe", b"Pixel Pepe", b"Pixels Pepe brings you 8 Bit greatness on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056616_44f1d2736c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXELPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXELPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

