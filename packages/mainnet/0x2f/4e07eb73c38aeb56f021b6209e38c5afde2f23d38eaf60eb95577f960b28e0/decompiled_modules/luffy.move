module 0x2f4e07eb73c38aeb56f021b6209e38c5afde2f23d38eaf60eb95577f960b28e0::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 6, b"Luffy", b"Monkey D. Luffy", b"One Piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6729_609ac2c4ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

