module 0x163b34884e8ec695e95dfcc7e80b08bd545adc8e6015d28c4b8619c5422840ee::suiro {
    struct SUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRO>(arg0, 6, b"SUIRO", b"Suiro Neko", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_02_22_27_23_2_d97cc59b79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

