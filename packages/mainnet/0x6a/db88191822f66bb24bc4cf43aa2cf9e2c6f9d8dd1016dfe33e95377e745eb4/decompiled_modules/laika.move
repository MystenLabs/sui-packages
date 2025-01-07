module 0x6adb88191822f66bb24bc4cf43aa2cf9e2c6f9d8dd1016dfe33e95377e745eb4::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIKA>(arg0, 8, b"LAIKA", b"Laika the Space Dog", b"Laika was a Soviet space dog who was one of the first animals in space and the first to orbit the Earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JVOBrX4.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAIKA>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

