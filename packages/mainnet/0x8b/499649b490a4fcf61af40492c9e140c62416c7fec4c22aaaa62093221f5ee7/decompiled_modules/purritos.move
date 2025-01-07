module 0x8b499649b490a4fcf61af40492c9e140c62416c7fec4c22aaaa62093221f5ee7::purritos {
    struct PURRITOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURRITOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURRITOS>(arg0, 6, b"PURRITOS", b"PURRITOS CAT", b"The Most MeowAble cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_18_at_09_00_21_c319281519.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURRITOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURRITOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

