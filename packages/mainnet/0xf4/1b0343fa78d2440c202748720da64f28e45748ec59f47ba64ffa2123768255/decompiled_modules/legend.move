module 0xf41b0343fa78d2440c202748720da64f28e45748ec59f47ba64ffa2123768255::legend {
    struct LEGEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGEND>(arg0, 6, b"LEGEND", b"legend", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:4000/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGEND>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEGEND>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

