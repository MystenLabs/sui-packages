module 0xdd941f0e1eca73ba83fafd361e14f911cecc53560bba82d1ae6e41854a89b45c::wud {
    struct WUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUD>(arg0, 6, b"WUD", b"Woofy Wud", b"WUD isn't just a meme-it's a flex a lifestyle a revolution  Stack gold, crush limits, and own the streets . If you're not in , you're OUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011855_16c9fdea50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

