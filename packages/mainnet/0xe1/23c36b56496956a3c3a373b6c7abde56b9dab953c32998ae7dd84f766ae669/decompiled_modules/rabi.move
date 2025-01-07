module 0xe123c36b56496956a3c3a373b6c7abde56b9dab953c32998ae7dd84f766ae669::rabi {
    struct RABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABI>(arg0, 6, b"RABI", b"Rabi", b"Meet Rabi, the majestic King of the Ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_14_T160734_836_0ef3f999f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

