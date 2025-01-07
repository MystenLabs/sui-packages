module 0xbc25489df94a3be760b71d2f9b4879faf279e7a34d7ced8495beb39bd6c6287c::nubcat {
    struct NUBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBCAT>(arg0, 6, b"Nubcat", b"NubCat", b"Nubcat on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6762_62ff13c5b8_39ce0ecd1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

