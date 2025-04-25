module 0x50e6b43795b7729d7a23f0b505a0cec089850d655ff54966d1f9e238ee8131d3::vemint {
    struct VEMINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEMINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEMINT>(arg0, 6, b"VEMINT", b"VEMINT PROTOCOL", b"Vemint envisions a world where artificial intelligence is seamlessly integrated into everyday life, making advanced technologies accessible, scalable, and impactful.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_03_25_19_06_35_9656e7e4cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEMINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEMINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

