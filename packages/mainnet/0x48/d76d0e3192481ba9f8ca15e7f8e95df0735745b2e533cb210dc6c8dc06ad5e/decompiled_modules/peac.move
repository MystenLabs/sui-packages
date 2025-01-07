module 0x48d76d0e3192481ba9f8ca15e7f8e95df0735745b2e533cb210dc6c8dc06ad5e::peac {
    struct PEAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEAC>(arg0, 6, b"PEAC", b"PeaceCoin", b"\"Support peace and harmony with PeaceCoin. Empower global initiatives for a better world.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732071673776.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

