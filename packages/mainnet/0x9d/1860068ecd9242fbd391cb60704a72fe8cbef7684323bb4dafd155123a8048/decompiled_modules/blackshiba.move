module 0x9d1860068ecd9242fbd391cb60704a72fe8cbef7684323bb4dafd155123a8048::blackshiba {
    struct BLACKSHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKSHIBA>(arg0, 6, b"BLACKSHIBA", b"Black Shiba", b"Create a world where all animals can feel loved and cared for.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_Shiba_Inu_dog_breed_c657d9f527.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKSHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKSHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

