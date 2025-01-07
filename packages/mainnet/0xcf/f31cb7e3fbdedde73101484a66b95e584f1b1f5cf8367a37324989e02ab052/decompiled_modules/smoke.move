module 0xcff31cb7e3fbdedde73101484a66b95e584f1b1f5cf8367a37324989e02ab052::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 6, b"SMOKE", b"BRETT SMOKE WEED", b"one of cryptos most significant cultural icons and the mascot of sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_21_41_18_c078486323.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

