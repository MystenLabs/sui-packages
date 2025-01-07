module 0xcaaf933de04c998da6fc01fc88597a3309aa93e18cd9689fdd29b6f6c0bcfc7a::ppsy {
    struct PPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPSY>(arg0, 6, b"PPSY", b"PEPE SAYAN", b"KAME HAME HAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_20_04_13_41_667b5559f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

