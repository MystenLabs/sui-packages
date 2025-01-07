module 0xe413d765f368e05692de57dcb5701455bdb555519b0bf4979451c8e638e860af::starship {
    struct STARSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIP>(arg0, 6, b"STARShip", b"STARSHIP", b"STARSHIPfight5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3674_e291195542.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

