module 0xe7e633ab7602c74dc6dabe12a9cd79e262617b5e03b8af9dad91320eeec8cf75::apixel {
    struct APIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: APIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APIXEL>(arg0, 6, b"aPIXEL", b"SUI Pixel", b"SUI PIXEL brings a retro twist to the blockchain with its pixelated SUI logo, combining nostalgia with cutting-edge technology. Each pixel represents the building blocks of innovation, connecting the past and future in a vibrant digital world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MGA_LOGO_2_e8f25769b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

