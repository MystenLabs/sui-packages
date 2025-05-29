module 0x53cc18d0d4537fe9356ce1c1cf466306ac344dc80beb8a7f4d9e39850c5b3bb2::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"Jiggly", b"Jiggly on sui", b"The unofficial Pokmon for moonbags ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2619_b1af7ad442.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIGGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

