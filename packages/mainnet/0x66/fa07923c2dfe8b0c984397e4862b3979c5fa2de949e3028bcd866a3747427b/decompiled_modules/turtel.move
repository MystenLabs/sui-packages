module 0x66fa07923c2dfe8b0c984397e4862b3979c5fa2de949e3028bcd866a3747427b::turtel {
    struct TURTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTEL>(arg0, 6, b"TURTEL", b"Turtel", b"The first blue turtle on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_13_39_12_9697d73fed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

