module 0x8bb0beb232bad3baa5edeb2efe0687e76382358e2c43e7aa07143d841a5e5c13::ghosui {
    struct GHOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOSUI>(arg0, 6, b"GHOSUI", b"GHOSTSUI", b"GHOST SUI always near you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ghost_blue_icon_vector_931697245b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

