module 0xc4052fad379c60ae1044d29613afd7072b99366a25ab6fc0434db4d2145d5c43::acat {
    struct ACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACAT>(arg0, 6, b"Acat", b"Akira Cat", b"A cat with an extraordinary dream; to swim in water on Sui Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_22_28_10_609e878ac9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

