module 0xf52f49842738084c095b406ccc779a390aa008447a7d7ef24bb95d07677e82e2::infinix {
    struct INFINIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<INFINIX>(arg0, 6, b"INFINIX", b"Ryam", b"n/a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_06_06_205726_11227760c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INFINIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

