module 0xf1a75a5bf85e193d4eeedf2820125b20d0061aacb2688b7cfbca5244ba82db3a::waif {
    struct WAIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAIF>(arg0, 6, b"WAIF", b"Waifu Companion", b"Meet your dream virtual girlfriend, the 'Waifu Companion' - an AI designed to be the epitome of cute, sexy, and irresistibly adorable. She's the perfect blend of charm and wit, tailored to be your ideal partner in digital life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/amara4_a5bfe054de.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

