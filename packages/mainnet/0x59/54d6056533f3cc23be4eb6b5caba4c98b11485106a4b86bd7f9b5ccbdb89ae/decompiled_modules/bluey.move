module 0x5954d6056533f3cc23be4eb6b5caba4c98b11485106a4b86bd7f9b5ccbdb89ae::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"BLUEY", b"BLUEY ON SUI", b"The new mascot has arrived, if you missed all the others, try this one so you don't miss it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluey_850453b598.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

