module 0x2e0769b474beb88c1bc4e5c4793cb680e2d4a55b174d62707b3becde65b272c8::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 6, b"SUIDOGE", b"SUI DOGE", b"Fresh out of the water. Newborn SUIDOGE rolls in the sand and enjoy the heat of the sun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_18_12_29_389c56f9b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

