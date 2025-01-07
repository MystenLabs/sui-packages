module 0x9ae57c6ef4fa35afbcd74f02cf8b55de943193b72785cde17ed2bd044df0b619::suiz {
    struct SUIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZ>(arg0, 6, b"SUIZ", b"Suizzle", b"Suizzle Army!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/public_d2c21c3653.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

