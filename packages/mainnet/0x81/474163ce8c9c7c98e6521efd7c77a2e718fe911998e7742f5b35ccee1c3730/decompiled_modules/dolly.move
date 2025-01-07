module 0x81474163ce8c9c7c98e6521efd7c77a2e718fe911998e7742f5b35ccee1c3730::dolly {
    struct DOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLY>(arg0, 6, b"DOLLY", b"DOLLY FAN ON SUI", b"DOLLY FAN The cutest dog in SUI, also a friend of Moodengs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_dolly_117f43969f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

