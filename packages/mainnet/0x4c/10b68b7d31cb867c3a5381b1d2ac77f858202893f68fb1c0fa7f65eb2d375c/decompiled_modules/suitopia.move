module 0x4c10b68b7d31cb867c3a5381b1d2ac77f858202893f68fb1c0fa7f65eb2d375c::suitopia {
    struct SUITOPIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOPIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOPIA>(arg0, 6, b"SUITOPIA", b"Suitopia", b"Welcome to the suitopia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suitopia_c1a0d76961.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOPIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOPIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

