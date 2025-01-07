module 0xa4f3e8f86aa791096a132fddcfb12a152552c7c7acdab2d4b90c208a1ff73274::kotgran {
    struct KOTGRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOTGRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOTGRAN>(arg0, 6, b"KOTGRAN", b"KotaroGranny", b"Just look ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3522_fe16662ab5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOTGRAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOTGRAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

