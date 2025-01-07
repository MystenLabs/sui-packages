module 0xe6e76e4a418325b52667fab32affa201f262a6a804bd8055c0bbf99b1ccc28da::fatniggacrocodilepizza {
    struct FATNIGGACROCODILEPIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATNIGGACROCODILEPIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATNIGGACROCODILEPIZZA>(arg0, 6, b"FATNIGGACROCODILEPIZZA", b"Fat nigga crocodile pizza", b" Fat nigga crocodile pizza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_15_14_54_b450a27ba9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATNIGGACROCODILEPIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATNIGGACROCODILEPIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

