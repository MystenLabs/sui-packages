module 0x36424efb46ef709c27f7b1633bd4bc5176f6c8ad57d1b96d0df973bc0a797e86::pu {
    struct PU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PU>(arg0, 6, b"PU", b"Peela ud", b"This coin is dedicate to sensitive people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000351786_05a6edc81c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PU>>(v1);
    }

    // decompiled from Move bytecode v6
}

