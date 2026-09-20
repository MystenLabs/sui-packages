module 0xd2d951e9f0f9ae6245daca428f526189e38ad9945d81c6550a1fda98bf49bca3::lamborghini {
    struct LAMBORGHINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBORGHINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBORGHINI>(arg0, 9, b"LAMBORGHINI", b"Lamborghini", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://launchdesk.38.242.215.238.sslip.io/assets/b11c45ef062cead105446aac0b569956d55e0b7747b0f7ffe0f514bd0f76d2c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBORGHINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAMBORGHINI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

