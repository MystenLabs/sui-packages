module 0xe60d94a1ce1200c3f8f8482aab1ced76e671ad00ba919288f4af819c392a3125::hisscy {
    struct HISSCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HISSCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HISSCY>(arg0, 6, b"HISSCY", b"Hisscy the Snake Cat", b"im a cat but 2025 is year of the snake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1096_14b12ccb31.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HISSCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HISSCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

